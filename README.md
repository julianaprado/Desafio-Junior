# Desafio Junior Stone

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

recebe uma complection, com @escaping para permitir que o bloco de código continue mesmo depois que a chamada à função acabe.

#### Com a chamada a API feita, passei a planejar o wireframe do aplicativo:

[Wireframe](https://github.com/julianaprado/Desafio-Junior/blob/dc20398f1188900e2826646fc1042ffddee7f36f/Imagens/Wireframe.png)



