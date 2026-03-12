// MainMenuView.swift
// The Appraiser — Home Screen

import SwiftUI

struct MainMenuView: View {
    @Environment(GameManager.self) var game

    var body: some View {
        ZStack {
            // Deep museum background
            Color(red: 0.07, green: 0.07, blue: 0.09).ignoresSafeArea()

            // Subtle texture grid
            Canvas { ctx, size in
                let spacing: CGFloat = 60
                ctx.stroke(Path { p in
                    var x: CGFloat = 0
                    while x < size.width {
                        p.move(to: CGPoint(x: x, y: 0))
                        p.addLine(to: CGPoint(x: x, y: size.height))
                        x += spacing
                    }
                    var y: CGFloat = 0
                    while y < size.height {
                        p.move(to: CGPoint(x: 0, y: y))
                        p.addLine(to: CGPoint(x: size.width, y: y))
                        y += spacing
                    }
                }, with: .color(Color.white.opacity(0.03)), lineWidth: 0.5)
            }.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // Logo / Title
                VStack(spacing: 16) {
                    // Emblem
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.12, green: 0.10, blue: 0.06))
                            .frame(width: 100, height: 100)
                        Circle()
                            .stroke(AppColors.gold.opacity(0.7), lineWidth: 1.5)
                            .frame(width: 100, height: 100)
                        Image(systemName: "scalemass.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(AppColors.gold)
                    }

                    Text("THE APPRAISER")
                        .font(.system(size: 42, weight: .thin, design: .serif))
                        .tracking(8)
                        .foregroundStyle(Color.white)

                    Text("Art Authentication & Appraisal")
                        .font(.system(size: 14, weight: .light))
                        .tracking(3)
                        .foregroundStyle(AppColors.gold.opacity(0.8))
                }

                Spacer().frame(height: 60)

                // Rank badge
                HStack(spacing: 12) {
                    Image(systemName: game.progress.rank.badge)
                        .font(.system(size: 18))
                        .foregroundStyle(AppColors.gold)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(game.progress.rank.rawValue)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color.white.opacity(0.85))
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.white.opacity(0.15))
                                    .frame(height: 4)
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(AppColors.gold)
                                    .frame(width: geo.size.width * game.progress.rankProgressFraction, height: 4)
                            }
                        }.frame(height: 4)
                        Text("\(game.progress.totalXP) XP")
                            .font(.system(size: 11))
                            .foregroundStyle(Color.white.opacity(0.5))
                    }
                }
                .padding(.horizontal, 28)
                .padding(.vertical, 16)
                .background(Color.white.opacity(0.06))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(AppColors.gold.opacity(0.2), lineWidth: 1))

                Spacer().frame(height: 50)

                // Main buttons
                VStack(spacing: 14) {
                    MenuButton(title: "ENTER THE GALLERY", subtitle: "Begin your appraisal career", icon: "building.columns.fill") {
                        game.goToLevelSelect()
                    }

                    if !game.progress.completedLevels.isEmpty {
                        MenuButton(title: "CONTINUE", subtitle: "Level \(game.progress.highestUnlockedLevel)", icon: "arrow.right.circle.fill") {
                            if let nextCase = LevelData.all.first(where: { $0.levelNumber == game.progress.highestUnlockedLevel }) {
                                game.startLevel(nextCase)
                            }
                        }
                    }
                }
                .frame(maxWidth: 400)

                Spacer().frame(height: 30)

                // Stats row
                HStack(spacing: 40) {
                    StatBadge(value: "\(game.progress.completedLevels.count)", label: "Cases Solved")
                    StatBadge(value: "$\(game.progress.totalMoneyEarned.formatted())", label: "Total Earned")
                }
                .foregroundStyle(Color.white.opacity(0.5))

                Spacer()

                // Footer
                Text("An art history learning experience")
                    .font(.system(size: 11))
                    .tracking(2)
                    .foregroundStyle(Color.white.opacity(0.25))
                    .padding(.bottom, 30)
            }
            .padding(.horizontal, 40)
        }
    }
}

// MARK: - Subviews

private struct MenuButton: View {
    let title: String
    let subtitle: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundStyle(AppColors.gold)
                    .frame(width: 32)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .tracking(1.5)
                        .foregroundStyle(Color.white)
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.white.opacity(0.5))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.white.opacity(0.3))
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .background(Color.white.opacity(0.07))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(AppColors.gold.opacity(0.2), lineWidth: 1))
        }
        .buttonStyle(.plain)
    }
}

private struct StatBadge: View {
    let value: String
    let label: String
    var body: some View {
        VStack(spacing: 3) {
            Text(value)
                .font(.system(size: 18, weight: .semibold, design: .monospaced))
                .foregroundStyle(Color.white.opacity(0.75))
            Text(label)
                .font(.system(size: 10))
                .tracking(1)
        }
    }
}

// MARK: - Color Theme
enum AppColors {
    static let gold = Color(red: 0.85, green: 0.72, blue: 0.38)
    static let background = Color(red: 0.07, green: 0.07, blue: 0.09)
    static let surface = Color(red: 0.12, green: 0.12, blue: 0.15)
    static let surfaceElevated = Color(red: 0.17, green: 0.17, blue: 0.21)
    static let textPrimary = Color.white
    static let textSecondary = Color.white.opacity(0.6)
    static let textMuted = Color.white.opacity(0.35)
    static let success = Color(red: 0.25, green: 0.80, blue: 0.55)
    static let failure = Color(red: 0.88, green: 0.30, blue: 0.30)
    static let accent = Color(red: 0.42, green: 0.72, blue: 0.95)
}

#Preview {
    MainMenuView().environment(GameManager())
}
