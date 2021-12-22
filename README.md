# Desafio Junior Stone

Este projeto consome a REST api do Rick and Morty, e exibe uma lista com os personagens. 

## Requisitos Obrigatórios Concluídos:
- Listagem de personagens (Com Paginação)
- Tela de detalhes do personagem

## Requisitos Opcionais Concluídos:
- Filtros de personagem

## Construção do projeto

###Início
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


###Criando o Character Data e o Character Manager

(Charcater Data)[https://github.com/julianaprado/Desafio-Junior/blob/3e8676e4082c8c7d3eb2fd5cda20a4d2b774c384/DesafioJunior/Model/CharactersData.swift]:

Criei o struct (permitindo cópia) com os dados que serão recebidos pela API.

(Character Manager)[https://github.com/julianaprado/Desafio-Junior/blob/3e8676e4082c8c7d3eb2fd5cda20a4d2b774c384/DesafioJunior/Model/CharactersManager.swift]:

O Character Manager é uma classe (objeto) que lida com os serviços da API e grava em sua instância, o Array contendo os personagens.




