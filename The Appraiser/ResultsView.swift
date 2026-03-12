// ResultsView.swift
// The Appraiser — Round Results & Debriefing

import SwiftUI

struct ResultsView: View {
    @Environment(GameManager.self) var game
    let result: RoundResult

    @State private var animateScore = false
    @State private var showExplanation = false
    @State private var expandedExplanation = false

    private var verdictColor: Color { result.wasCorrect ? AppColors.success : AppColors.failure }
    private var verdictIcon: String { result.wasCorrect ? "checkmark.seal.fill" : "xmark.seal.fill" }
    private var verdictLabel: String { result.wasCorrect ? "CORRECT ASSESSMENT" : "INCORRECT ASSESSMENT" }

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            // Subtle ambient glow behind verdict
            RadialGradient(
                colors: [verdictColor.opacity(0.08), .clear],
                center: .top,
                startRadius: 0,
                endRadius: 500
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    verdictHeader
                    scoreStrip
                    Divider().background(AppColors.gold.opacity(0.2))
                    answerComparison
                    Divider().background(AppColors.gold.opacity(0.2))
                    educationalSection
                    Divider().background(AppColors.gold.opacity(0.2))
                    toolsBreakdown
                    rankProgressSection
                    actionButtons
                }
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                animateScore = true
            }
            withAnimation(.easeOut(duration: 0.6).delay(1.0)) {
                showExplanation = true
            }
        }
    }

    // MARK: - Verdict Header

    private var verdictHeader: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 40)

            // Animated badge
            ZStack {
                Circle()
                    .fill(verdictColor.opacity(0.12))
                    .frame(width: 120, height: 120)
                    .scaleEffect(animateScore ? 1.0 : 0.4)
                    .animation(.spring(response: 0.6, dampingFraction: 0.65).delay(0.2), value: animateScore)

                Circle()
                    .stroke(verdictColor.opacity(0.4), lineWidth: 2)
                    .frame(width: 120, height: 120)
                    .scaleEffect(animateScore ? 1.0 : 0.4)
                    .animation(.spring(response: 0.6, dampingFraction: 0.65).delay(0.25), value: animateScore)

                Image(systemName: verdictIcon)
                    .font(.system(size: 54))
                    .foregroundStyle(verdictColor)
                    .scaleEffect(animateScore ? 1.0 : 0.1)
                    .animation(.spring(response: 0.7, dampingFraction: 0.55).delay(0.35), value: animateScore)
            }

            VStack(spacing: 6) {
                Text(verdictLabel)
                    .font(.system(size: 15, weight: .semibold))
                    .tracking(3)
                    .foregroundStyle(verdictColor)

                Text(result.wasCorrect
                     ? "Your analysis was correct. The client is satisfied."
                     : "Your assessment did not match the evidence. The client disputes your findings.")
                    .font(.system(size: 14))
                    .foregroundStyle(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            .opacity(animateScore ? 1 : 0)
            .animation(.easeOut(duration: 0.5).delay(0.5), value: animateScore)

            Spacer().frame(height: 20)
        }
        .padding(.horizontal, 24)
    }

    // MARK: - Score Strip

    private var scoreStrip: some View {
        HStack(spacing: 0) {
            ScoreTile(
                label: "Money",
                value: (result.moneyDelta >= 0 ? "+" : "") + "$\(result.moneyDelta.formatted())",
                icon: "dollarsign.circle.fill",
                color: result.moneyDelta >= 0 ? AppColors.success : AppColors.failure,
                animate: animateScore
            )
            Divider().background(AppColors.gold.opacity(0.2))
            ScoreTile(
                label: "XP Earned",
                value: "+\(result.xpEarned)",
                icon: "star.fill",
                color: AppColors.gold,
                animate: animateScore
            )
            Divider().background(AppColors.gold.opacity(0.2))
            ScoreTile(
                label: "Tools Used",
                value: "\(result.toolsUsed.count)",
                icon: "wrench.and.screwdriver.fill",
                color: AppColors.accent,
                animate: animateScore
            )
            Divider().background(AppColors.gold.opacity(0.2))
            ScoreTile(
                label: "Investigation Cost",
                value: "-$\(result.spentOnTools.formatted())",
                icon: "receipt",
                color: result.spentOnTools > 0 ? AppColors.failure.opacity(0.8) : AppColors.textMuted,
                animate: animateScore
            )
        }
        .frame(height: 80)
        .background(AppColors.surface)
    }

    // MARK: - Answer Comparison

    private var answerComparison: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label("VERDICT BREAKDOWN", systemImage: "doc.text.magnifyingglass")
                .font(.system(size: 10, weight: .bold)).tracking(3)
                .foregroundStyle(AppColors.gold)

            HStack(alignment: .top, spacing: 12) {
                // Player's answer
                VStack(alignment: .leading, spacing: 6) {
                    Label("YOUR ANSWER", systemImage: "person.fill")
                        .font(.system(size: 9, weight: .semibold)).tracking(2)
                        .foregroundStyle(AppColors.textMuted)
                    Text(result.playerChoice)
                        .font(.system(size: 15, weight: .semibold, design: .serif))
                        .foregroundStyle(result.wasCorrect ? AppColors.success : AppColors.failure)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(14)
                .background((result.wasCorrect ? AppColors.success : AppColors.failure).opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(
                    (result.wasCorrect ? AppColors.success : AppColors.failure).opacity(0.3), lineWidth: 1))

                if !result.wasCorrect {
                    Image(systemName: "arrow.right")
                        .foregroundStyle(AppColors.textMuted)
                        .padding(.top, 18)

                    // Correct answer (only shown if wrong)
                    VStack(alignment: .leading, spacing: 6) {
                        Label("CORRECT ANSWER", systemImage: "checkmark.circle.fill")
                            .font(.system(size: 9, weight: .semibold)).tracking(2)
                            .foregroundStyle(AppColors.textMuted)
                        Text(result.correctAnswer)
                            .font(.system(size: 15, weight: .semibold, design: .serif))
                            .foregroundStyle(AppColors.success)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(14)
                    .background(AppColors.success.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(AppColors.success.opacity(0.3), lineWidth: 1))
                }
            }
        }
        .padding(24)
        .opacity(showExplanation ? 1 : 0)
        .animation(.easeOut(duration: 0.5), value: showExplanation)
    }

    // MARK: - Educational Section

    private var educationalSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label("ART HISTORY NOTES", systemImage: "book.closed.fill")
                .font(.system(size: 10, weight: .bold)).tracking(3)
                .foregroundStyle(AppColors.gold)

            VStack(alignment: .leading, spacing: 12) {
                Text(result.explanation)
                    .font(.system(size: 15, design: .serif))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(6)
                    .lineLimit(expandedExplanation ? nil : 5)

                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        expandedExplanation.toggle()
                    }
                } label: {
                    Label(expandedExplanation ? "Show less" : "Read more",
                          systemImage: expandedExplanation ? "chevron.up" : "chevron.down")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(AppColors.gold)
                }
                .buttonStyle(.plain)
            }
            .padding(18)
            .background(AppColors.surfaceElevated)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(AppColors.gold.opacity(0.2), lineWidth: 1)
            )
        }
        .padding(24)
        .opacity(showExplanation ? 1 : 0)
        .animation(.easeOut(duration: 0.5).delay(0.1), value: showExplanation)
    }

    // MARK: - Tools Breakdown

    private var toolsBreakdown: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("TOOLS USED", systemImage: "wrench.and.screwdriver")
                .font(.system(size: 10, weight: .bold)).tracking(3)
                .foregroundStyle(AppColors.gold)

            if result.toolsUsed.isEmpty {
                Text("No tools were used. Sometimes intuition is enough — but for harder cases, every tool counts.")
                    .font(.system(size: 13))
                    .italic()
                    .foregroundStyle(AppColors.textMuted)
            } else {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(result.toolsUsed, id: \.self) { tool in
                        HStack(spacing: 8) {
                            Image(systemName: tool.icon)
                                .font(.system(size: 14))
                                .foregroundStyle(AppColors.gold)
                                .frame(width: 28)
                            VStack(alignment: .leading, spacing: 1) {
                                Text(tool.rawValue)
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundStyle(AppColors.textPrimary)
                                Text(tool.costLabel)
                                    .font(.system(size: 10))
                                    .foregroundStyle(AppColors.textMuted)
                            }
                        }
                        .padding(10)
                        .background(AppColors.surfaceElevated)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
        .padding(24)
        .opacity(showExplanation ? 1 : 0)
        .animation(.easeOut(duration: 0.5).delay(0.2), value: showExplanation)
    }

    // MARK: - Rank Progress

    private var rankProgressSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("YOUR PROGRESS", systemImage: "chart.line.uptrend.xyaxis")
                .font(.system(size: 10, weight: .bold)).tracking(3)
                .foregroundStyle(AppColors.gold)

            HStack(spacing: 16) {
                Image(systemName: game.progress.rank.badge)
                    .font(.system(size: 28))
                    .foregroundStyle(AppColors.gold)

                VStack(alignment: .leading, spacing: 6) {
                    Text(game.progress.rank.rawValue)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(AppColors.textPrimary)

                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.white.opacity(0.1))
                                .frame(height: 8)
                            RoundedRectangle(cornerRadius: 4)
                                .fill(AppColors.gold)
                                .frame(
                                    width: animateScore
                                        ? geo.size.width * game.progress.rankProgressFraction
                                        : 0,
                                    height: 8
                                )
                                .animation(.easeOut(duration: 1.0).delay(0.6), value: animateScore)
                        }
                    }
                    .frame(height: 8)

                    Text("\(game.progress.totalXP) XP total")
                        .font(.system(size: 11, design: .monospaced))
                        .foregroundStyle(AppColors.textMuted)
                }
            }
            .padding(16)
            .background(AppColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(AppColors.gold.opacity(0.2), lineWidth: 1))
        }
        .padding(24)
        .opacity(showExplanation ? 1 : 0)
        .animation(.easeOut(duration: 0.5).delay(0.3), value: showExplanation)
    }

    // MARK: - Action Buttons

    private var actionButtons: some View {
        VStack(spacing: 12) {
            // Next level if available
            let nextLevelNum = (result.levelID) + 1
            if let nextCase = LevelData.all.first(where: { $0.levelNumber == nextLevelNum }),
               game.isUnlocked(nextCase) {
                Button {
                    game.startLevel(nextCase)
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.right.circle.fill")
                        Text("NEXT CASE — \(nextCase.title.uppercased())")
                            .tracking(1)
                    }
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(AppColors.background)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(AppColors.gold)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .buttonStyle(.plain)
            }

            HStack(spacing: 12) {
                Button {
                    if let currentCase = LevelData.all.first(where: { $0.id == result.levelID }) {
                        game.startLevel(currentCase)
                    }
                } label: {
                    Label("Retry", systemImage: "arrow.clockwise")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(AppColors.textSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(AppColors.surfaceElevated)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)

                Button {
                    game.goToLevelSelect()
                } label: {
                    Label("Case Files", systemImage: "list.bullet.rectangle")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(AppColors.textSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(AppColors.surfaceElevated)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(24)
        .opacity(showExplanation ? 1 : 0)
        .animation(.easeOut(duration: 0.5).delay(0.4), value: showExplanation)
    }
}

// MARK: - Score Tile

private struct ScoreTile: View {
    let label: String
    let value: String
    let icon: String
    let color: Color
    let animate: Bool

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundStyle(color)
            Text(value)
                .font(.system(size: 15, weight: .bold, design: .monospaced))
                .foregroundStyle(color)
                .scaleEffect(animate ? 1.0 : 0.5)
                .animation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.4), value: animate)
            Text(label)
                .font(.system(size: 9))
                .tracking(1)
                .foregroundStyle(AppColors.textMuted)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ResultsView(result: RoundResult(
        levelID: 1,
        wasCorrect: true,
        moneyDelta: 4200,
        xpEarned: 130,
        toolsUsed: [.magnifyingGlass, .chemicalAnalysis],
        spentOnTools: 1800,
        playerChoice: "Forgery",
        correctAnswer: "Forgery",
        explanation: "Van Gogh is among the most forged artists of the 20th century. Authenticators rely on pigment chemistry, stylistic analysis, and provenance research."
    )).environment(GameManager())
}
