# Desafio

Este projeto consome a REST api do Rick and Morty, e exibe uma lista com os personagens. 

## Requisitos Obrigatórios Concluídos:
- Listagem de personagens (Com Paginação)
- Tela de detalhes do personagem

## Requisitos Opcionais Concluídos:
- Filtros de personagem

## Construção do projeto

### Início
De início preparei o projeto para ser em UiKit e ViewCode, e para isso, construí a [AppContainer](https://github.com/julianaprado/Desafio-Junior/blob/17ecda5d35a806b9c4f4712815940f71b86f8750/DesafioJunior/Main/AppContainer.swift) que utiliza o Factory Pattern para defiir uma interface para construir ViewControllers.

Com isso, bastou trocar o código do SceneDelegate para:

```
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 1. Capture the scene if there is one into a variable
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 2. Create a new UIWindow with a ViewController
        let window = UIWindow(windowScene: windowScene)
        let rootViewController = appContainer.createNavigationController()
        
        window.rootViewController = rootViewController
        
        // 3. Set the window and make it keyAndVisible
        self.window = window
        window.makeKeyAndVisible()
}
```

E deletar o arquivo main.storyboard, e o app estava abrindo para a Loading Screen!


### Criando o Character Data e o Character Manager

#### [Charcater Data](https://github.com/julianaprado/Desafio-Junior/blob/3e8676e4082c8c7d3eb2fd5cda20a4d2b774c384/DesafioJunior/Model/CharactersData.swift):

Criei o struct (permitindo cópia) com os dados que serão recebidos pela API.

#### [Character Manager](https://github.com/julianaprado/Desafio-Junior/blob/3e8676e4082c8c7d3eb2fd5cda20a4d2b774c384/DesafioJunior/Model/CharactersManager.swift):

O Character Manager é uma classe (objeto) que lida com os serviços da API e grava em sua instância, o Array contendo os personagens. A função getCharacter:

```
/// Function parse JSON data
/// - Parameter completion: Completion that returns a charactersData Array if success, or Error enum if failure
private func getCharacters(completion: @escaping (Result<[CharactersData]?, e>) -> Void) {
        
        // 1.Create a URL
        guard let url = URL(string: self.requestURL) else {
            completion(.failure(e.urlError))
            return
        }
        // 2. Create a URLSession
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let charactersData = data else{
                completion(.failure(e.noData))
                return
        }
            //3. Parse Data
            do {
                let decoder = JSONDecoder()
                let charactersResponse = try! decoder.decode(CharactersData.self, from: charactersData)
                completion(.success([charactersResponse]))
            }
        }
            // 4. Start the task
         dataTask.resume()
}
```

recebe uma completion, com @escaping para permitir que o bloco de código continue mesmo depois que a chamada à função acabe.

#### Front-End

Com a chamada a API feita, passei a planejar o wireframe do aplicativo:
![Wireframe](https://github.com/julianaprado/Desafio-Junior/blob/dc20398f1188900e2826646fc1042ffddee7f36f/Imagens/Wireframe.png)

#### ViewController e Navegação

Com o front-end feito, segui para a navegação. Utilizei o UiTableView para criar a lista com os personagens e, por meio do protocolo `delegate`, foi possível apresentar modalmente a página do personagem selecionado com o `navController.present(viewController, animated: false)`.

Para a paginação, foi feito o cálculo de quando o usuário chegasse ao fim do scrollview, para, então, fazer um novo request à API com a página em questão. Para voltar a página anterior, foi utilizado o UIRefreshControl para detectar quando o usuário puxa a o topo da TableView.

##### Atenção: Bugs!!

Quando o usuário puxa a tableview para pegar a próxima página, a tableView não refresca a view das duas primeiras sections, mas refresca a Data.
Apesar de fazer:
```
DispatchQueue.main.async{
  self.mainView.tableView.reloadData()
            
  let indexPath = IndexPath(row: 0, section: 0)
  self.mainView.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
}
self.mainView.tableView.reloadSections([0,1], with: .automatic)
```
Este bug é interessante, mas como queria fazer o filtro, segui adiante para poder ver ele com mais calma.

#### Filtro

Criando uma view para filtro, com fundo transparente:

```
/// Adds the tranparent background to the view
    func addTransparentBackground(){
        //only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)

            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            self.addSubview(blurEffectView)
        } else {
            self.backgroundColor = .black
        }

        self.frame = UIScreen.main.bounds
    }
```

Onde uma UIView é criada e adicionada na View original com um tamanho reduzido, dando um efeito de popUp.
Este tipo de view porém, gera memory leaks quando não é popped da Navigation Stack.

Apesar de estar popping ela da navigation stack utilizando a extensão de NavigationController criada:

```
///Extension to allow to pop to a given ViewController
extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
      if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
        popToViewController(vc, animated: animated)
      }
    }
}
```
E dismissing ela na ViewDidDisapear:

```
 override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ///since this view was presented modally, it has to be dismissed
        self.dismiss(animated: false, completion: nil)
    }

```
Aparentemente, a FilterView ainda não está sendo dismissed corretamente, o aplicativo aparenta estar com um memoryleak:

![Memory Leak](https://github.com/julianaprado/Desafio-Junior/blob/c23beaf421394a2382b8ede1e845e065c2598b93/Imagens/memoryleak.png)

Ela está guardando na stack cada instância dela.

### Apesar do memory leak.....

A funcionalidade de adicionar um filtro funciona por meio de delegates, fazendo um request na api com a sting dos itens selecionados na view, e enviando ao ViewController o novo characterManager.

### Boas práticas

Utilizei os princípios do Clean Code e SOLID, tornando o código o mais reutilizável possível, e comentando os trechos de código para que terceiros consigam entender. Todas as Views foram feitas com o mesmo princípio, separarei as chamadas a self.addSubview() em funções de hierarchy, e as constraints foram feitas em funções separadas de setupLayout.

O projeto foi feito em MVC.
Para as pastas de Controller e View, cada cena foi separada em pastas Scene, com as delegates em pastas de Delegates utilizados para aquela cena, estando dentro de View/Scene/Delegate.

### Finalmente

Adorei fazer esse projeto, passei 7 dias brincando com essa api e queria me aprofundar na criação de um Layout mais robusto, mas para conseguir entregar tudo em 7 dias, me contive. Me diverti resolvendo bugs inesperados e quebrando a cabeça em bugs que tinham tudo para serem resolvidos..
E, apesar de existir as pastas de Teste, não tenho prática nesta área e preferi focar nos outros elementos.

:) 
