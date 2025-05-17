//
//  PreferencesQuestionModel.swift
//  Coffice
//
//  Created by Al Amin Dwiesta on 16/05/25.
//
import Foundation

struct PreferenceQuestion: Identifiable {
    let id = UUID()
    let text: String
    let associatedTag: CoffeeTag
    let associatedNegativeTag: CoffeeTag?
}

struct PreferenceTagLine:Identifiable{
    let id = UUID()
    let tagLine: String
    let associatedTag: CoffeeTag
}

let preferenceTagLines: [PreferenceTagLine] = [
    PreferenceTagLine(tagLine: "Craving something smooth and cozy?", associatedTag: .creamy),
    PreferenceTagLine(tagLine: "Feeling like a cool and refreshing kind of day?", associatedTag: .iced),
    PreferenceTagLine(tagLine: "Got a sweet tooth today?", associatedTag: .sweet),
    PreferenceTagLine(tagLine: "Need that bold kick to jumpstart your day?", associatedTag: .strong),
    PreferenceTagLine(tagLine: "Nothing beats that warm cup, right?", associatedTag: .hot),
    PreferenceTagLine(tagLine: "Because you like it dark and deep — no sugar needed.", associatedTag: .bitter)
]

let preferenceQuestions: [PreferenceQuestion] = [
    PreferenceQuestion(
        text: "Do you usually go for something smooth and comforting?",
        associatedTag: .creamy,
        associatedNegativeTag: .strong
    ),
    PreferenceQuestion(
        text: "Do you enjoy your drink feeling light and refreshing?",
        associatedTag: .iced,
        associatedNegativeTag: .hot
    ),
    PreferenceQuestion(
        text: "Do you tend to avoid anything too intense?",
        associatedTag: .sweet,
        associatedNegativeTag: .bitter
    ),
    PreferenceQuestion(
        text: "Do you reach for something bold when you need a boost?",
        associatedTag: .strong,
        associatedNegativeTag: .creamy
    ),
    PreferenceQuestion(
        text: "Do you enjoy drinks that linger with depth?",
        associatedTag: .bitter,
        associatedNegativeTag: .sweet
    ),
    PreferenceQuestion(
        text: "Does warmth in your cup make it feel just right?",
        associatedTag: .hot,
        associatedNegativeTag: .iced
    )
]

