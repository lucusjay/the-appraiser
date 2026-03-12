// GameManager.swift
// The Appraiser — Central Game State

import Foundation
import SwiftUI

@Observable
final class GameManager {

    // MARK: - Navigation
    enum Screen {
        case mainMenu
        case levelSelect
        case gameplay(AppraisalCase)
        case results(RoundResult)
    }
    var currentScreen: Screen = .mainMenu

    // MARK: - Player State
    var progress: PlayerProgress = PlayerProgress()

    // MARK: - Current Round
    var roundState: RoundState = RoundState(budget: 0)
    var currentCase: AppraisalCase? = nil

    // MARK: - Init — load saved progress
    init() {
        loadProgress()
    }

    // MARK: - Navigation helpers
    func goToMainMenu() { currentScreen = .mainMenu }
    func goToLevelSelect() { currentScreen = .levelSelect }

    func startLevel(_ artCase: AppraisalCase) {
        currentCase = artCase
        roundState = RoundState(budget: artCase.startingBudget)
        currentScreen = .gameplay(artCase)
    }

    func submitAnswer() {
        guard let artCase = currentCase,
              let choiceIndex = roundState.selectedChoiceIndex else { return }

        let correct = choiceIndex == artCase.correctChoiceIndex
        let toolCost = roundState.spentAmount
        let expertCost = roundState.expertConsulted ? artCase.expert.cost : 0
        let totalCost = toolCost + expertCost

        let moneyDelta: Int
        let xpEarned: Int
        if correct {
            moneyDelta = artCase.successPayout - totalCost
            xpEarned = artCase.baseXP + bonusXP(toolsUsed: roundState.usedTools.count)
        } else {
            moneyDelta = -(artCase.failurePenalty + totalCost)
            xpEarned = max(20, artCase.baseXP / 5)
        }

        let result = RoundResult(
            levelID: artCase.id,
            wasCorrect: correct,
            moneyDelta: moneyDelta,
            xpEarned: xpEarned,
            toolsUsed: Array(roundState.usedTools),
            spentOnTools: totalCost,
            playerChoice: artCase.choices[choiceIndex],
            correctAnswer: artCase.correctAnswer.shortAnswer,
            explanation: artCase.correctAnswer.educationalExplanation
        )

        // Update progress
        progress.totalXP = max(0, progress.totalXP + xpEarned)
        progress.totalMoneyEarned += max(0, moneyDelta)
        if correct && !progress.completedLevels.contains(artCase.id) {
            progress.completedLevels.append(artCase.id)
            let nextLevel = artCase.levelNumber + 1
            if nextLevel <= LevelData.all.count {
                progress.highestUnlockedLevel = max(progress.highestUnlockedLevel, nextLevel)
            }
        }
        saveProgress()

        currentScreen = .results(result)
    }

    // MARK: - Tool Use
    func canUseTool(_ tool: ToolType) -> Bool {
        roundState.remainingBudget >= tool.cost
    }

    func useTool(_ tool: ToolType) {
        guard let artCase = currentCase else { return }
        guard let finding = artCase.toolFindings[tool] else { return }
        roundState.activate(tool: tool, finding: finding)
    }

    func consultExpert() {
        guard let artCase = currentCase else { return }
        guard !roundState.expertConsulted else { return }
        guard roundState.remainingBudget >= artCase.expert.cost else { return }
        roundState.expertConsulted = true
        roundState.spentAmount += artCase.expert.cost
    }

    func markBookRead(_ book: ReferenceBook) {
        roundState.booksRead.insert(book.id)
    }

    func setActiveOverlay(_ tool: ToolType?) {
        roundState.activeToolOverlay = tool
    }

    func selectChoice(_ index: Int) {
        roundState.selectedChoiceIndex = index
    }

    // MARK: - Level Access
    func isUnlocked(_ level: AppraisalCase) -> Bool {
        level.levelNumber <= progress.highestUnlockedLevel
    }

    func isCompleted(_ level: AppraisalCase) -> Bool {
        progress.completedLevels.contains(level.id)
    }

    // MARK: - Private helpers
    private func bonusXP(toolsUsed: Int) -> Int {
        // Bonus for efficiency — fewer tools used gets more bonus
        switch toolsUsed {
        case 0...1: return 50
        case 2...3: return 30
        case 4...5: return 10
        default: return 0
        }
    }

    // MARK: - Persistence
    private let progressKey = "com.theappraiser.progress"

    private func saveProgress() {
        if let data = try? JSONEncoder().encode(progress) {
            UserDefaults.standard.set(data, forKey: progressKey)
        }
    }

    private func loadProgress() {
        guard let data = UserDefaults.standard.data(forKey: progressKey),
              let saved = try? JSONDecoder().decode(PlayerProgress.self, from: data)
        else { return }
        progress = saved
    }

    func resetProgress() {
        progress = PlayerProgress()
        UserDefaults.standard.removeObject(forKey: progressKey)
    }
}
