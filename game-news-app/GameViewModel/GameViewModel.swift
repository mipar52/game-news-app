//
//  GameViewModel.swift
//  game-news-app
//
//  Created by Milan Parađina on 01.05.2023..
//

import Foundation
import Combine
import CombineCocoa
class GameViewModel {
    struct Input {
        let buttonTapPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Void, Never>
    }
    
    //    func tranform(input: Input) -> Output {
    //
    //        input.buttonTapPublisher.handleEvents { [unowned self] in
    //            print("tapped")
    //        }.flatMap { _ in
    //            return Just(())
    //        }.eraseToAnyPublisher()
    //
    //
    //}
}
