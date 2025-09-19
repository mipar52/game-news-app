# gameNEWS application

A simple application which fetches data from [RAWG.io API](https://rawg.io/) to obtain information about various video game categories and information like metacritic scores, playtime and other information.  

## Application flow:
The application consists of several ViewControllers and custom views to give the end-user information about the application itself and how to use it, game categories, lists and game detailes. In the application, video game information like ratings, release date, screenshots, game store availability can be found.

### ViewControllers
- ViewControllers can be found in [ViewController](https://github.com/mipar52/game-news-app/tree/main/game-news-app/ViewController) folder.
- The application consists of four ViewControllers:
    - Onboarding [ViewController](https://github.com/mipar52/game-news-app/blob/main/game-news-app/ViewController/OnboardingViewController.swift)
    - Game category [TableViewController](https://github.com/mipar52/game-news-app/blob/main/game-news-app/ViewController/GameGenreSelectTableViewController.swift)
    - Game list [TableViewController](https://github.com/mipar52/game-news-app/blob/main/game-news-app/ViewController/GameListTableViewController.swift)
    - Game detail [ViewController](https://github.com/mipar52/game-news-app/blob/main/game-news-app/ViewController/GameDetailTableViewController.swift)

### Custom views
- Custom views were mainly used for the Onboarding and GameDetail ViewControllers to give a better and more descriptive UI to the end-user
- All of the custom views can be found in the [View](https://github.com/mipar52/game-news-app/tree/main/game-news-app/View) folder
- Generic UI elements, like label, buttons and UIAlerts can be found [UIFactory](https://github.com/mipar52/game-news-app/tree/main/game-news-app/UIFactory) folder

### Model
- The application consists of a few model files, which can be found in the [Model](https://github.com/mipar52/game-news-app/tree/main/game-news-app/Model) folder:
    - [NetworkError](https://github.com/mipar52/game-news-app/blob/main/game-news-app/Model/NetworkError.swift) : and enum which conforms to the Error protocol to give more details of the possible network issues end-user might come across during game search
    - [GameGanres](https://github.com/mipar52/game-news-app/blob/main/game-news-app/Model/GameGenres.swift) : information from the verious video game categories from the API
    - [GameList](https://github.com/mipar52/game-news-app/blob/main/game-news-app/Model/GameList.swift) : information about the games about a speicific game categories
    - [Game](https://github.com/mipar52/game-news-app/blob/main/game-news-app/Model/Game.swift) : information about a specific game

### Managers:
- The application has two managers, which can be found in the [Manager](https://github.com/mipar52/game-news-app/tree/main/game-news-app/Manager) folder:
    - [NetworkManager](https://github.com/mipar52/game-news-app/blob/main/game-news-app/Manager/NetworkManager.swift) : manager who is in charge of communicating with the RAWG.io API to get video game information
    - [FirebaseManager](https://github.com/mipar52/game-news-app/blob/main/game-news-app/Manager/FirebaseManager.swift) : manager who is in charge of sending user events to Firebase

## Third party libraries
- [SnapKit](https://github.com/SnapKit/SnapKit): framework for auto-layout
- [Kingfisher](https://github.com/onevcat/Kingfisher): framework for smoothly downloading images
- [Firebase](https://github.com/firebase/firebase-ios-sdk): in this case, for event tracking

## Running the project 

    1. Just git clone the project and run the application via Xcode!
