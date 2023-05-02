//
//  Text.swift
//  game-news-app
//
//  Created by Milan Parađina on 28.04.2023..
//

import Foundation

struct Text {
    struct UIStrings {
        static let start = "Let's get started"
        static let findAGame = "Trying to find a game?"
        static let game = "game"
        static let news = "NEWS"
        static let animationLabel = "Everything game related"
        static let bottomLabelStartScreen = "Don't worry, you can always go back and pick another category :)"
        static let pickCategory = "Pick a category"
        
        static let onboardingTitleOne = "Application info"
        static let onboardingTitleTwo = "Getting started"
        static let oboardingTitleThree = "Searching"
        static let onboardingTitleFour = "Game details"
        static let onboardingTitleFive = "Source code"
        
        static let onboardingTextOne = "This simple application uses RAWG.io API to fetch data about various trending and non-trending video games for different gaming platforms"
        static let onboardingTextTwo = "Once you read the onboarding text, you can start by pressing the yellow button in the field below to search for a specific gaming category. Each category contains the six most popular games"
        static let onboardingTextThree = "Once you select your categories, you can filter the games by alphabetical order, highest score, lowest score and by playtime"
        static let onboardingTextFour = "You can even enter a specific game, where you can view its metascore, ratings, platforms & store availability."
        static let onboardingTextFive = "Like the app?\nYou can see the source-code on my GitHub page here!"
        static let loadingData = "Loading game data..."
        static let sortGames = "Sort Games"
        static let sortOne = "Aphabetical: A → Z"
        static let sortTwo = "Reverse: Z → A"
        static let sortThree = "Best Metacritic: 10 → 1"
        static let sortFour = "Worst Metacritic: 1 → 10"

    }
    
    struct Alert {
        static let errorTitle = "Error"
        static let exitTitle = "Exit"
        static let errorMessage = "Error with getting the data!\nMake sure you have a stable internet connecting and try again!"
        static let exitMessage = "Are you sure you want to exit the application?\nYou can always go back, but still..."
        static let categories = "Loading categories..."
        static let games = "Loading games..."
        static let ok = "Sure"
        static let yes = "Yes"
        static let cancel = "Cancel"
    }
    
    struct UIImages {
        static let logoViewImageDpad = "dpad"
        static let logoViewImageGameController = "gamecontroller"
        static let onboardingImageTwo = "lasso.and.sparkles"
        static let onboardingImageThree = "line.3.horizontal.circle"
        static let onboardingImageFour = "playstation.logo"
        static let onboardingImageFive = "laptopcomputer"
        static let restartArrow = "arrow.left"
        static let sortSlider = "slider.horizontal.3"
        static let controllerFill = "gamecontroller.fill"
    }
}
