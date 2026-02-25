// LevelSelectView.swift
// The Appraiser — Level Selection

import SwiftUI

struct LevelSelectView: View {
    @Environment(GameManager.self) var game
    @State private var selectedCase: AppraisalCase? = nil

    let columns = [GridItem(.adaptive(minimum: 320, maximum: 420), spacing: 20)]

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                header

                // Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(LevelData.all) { artCase in
                            LevelCard(
                                artCase: artCase,
                                isUnlocked: game.isUnlocked(artCase),
                                isCompleted: game.isCompleted(artCase)
                            )
                            .onTapGesture {
                                if game.isUnlocked(artCase) {
                                    selectedCase = artCase
                                }
                            }
                        }
                    }
                    .padding(24)
                }
            }
        }
        .sheet(item: $selectedCase) { artCase in
            CasePreviewSheet(artCase: artCase) {
                selectedCase = nil
                game.startLevel(artCase)
            }
        }
    }

    private var header: some View {
        HStack {
            Button {
                game.goToMainMenu()
            } label: {
                Label("Back", systemImage: "chevron.left")
                    .font(.system(size: 14))
                    .foregroundStyle(AppColors.gold)
            }
            .buttonStyle(.plain)

            Spacer()

            VStack(spacing: 2) {
                Text("CASE FILES")
                    .font(.system(size: 20, weight: .thin))
                    .tracking(6)
                    .foregroundStyle(AppColors.textPrimary)
                Text("\(game.progress.completedLevels.count) of \(LevelData.all.count) solved")
                    .font(.system(size: 11))
                    .foregroundStyle(AppColors.textMuted)
            }

            Spacer()

            // XP display
            HStack(spacing: 6) {
                Image(systemName: "star.fill")
                    .font(.system(size: 12))
                    .foregroundStyle(AppColors.gold)
                Text("\(game.progress.totalXP) XP")
                    .font(.system(size: 13, weight: .medium, design: .monospaced))
                    .foregroundStyle(AppColors.textSecondary)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
        .background(AppColors.surface)
        .overlay(alignment: .bottom) {
            Rectangle().fill(AppColors.gold.opacity(0.2)).frame(height: 1)
        }
    }
}

// MARK: - Level Card

private struct LevelCard: View {
    let artCase: AppraisalCase
    let isUnlocked: Bool
    let isCompleted: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Artwork preview strip
            ZStack(alignment: .bottomLeading) {
                ArtworkThumbnail(artwork: artCase.artwork, style: artCase.artwork.artStyle)
                    .frame(height: 120)
                    .clipped()

                // Overlay gradient
                LinearGradient(
                    colors: [.clear, artCase.artwork.darkColor.opacity(0.85)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 120)

                // Level badge
                HStack {
                    Text("CASE \(artCase.levelNumber)")
                        .font(.system(size: 10, weight: .semibold))
                        .tracking(2)
                        .foregroundStyle(AppColors.gold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.black.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 4))

                    Spacer()

                    if isCompleted {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(AppColors.success)
                            .font(.system(size: 18))
                    } else if !isUnlocked {
                        Image(systemName: "lock.fill")
                            .foregroundStyle(Color.white.opacity(0.5))
                            .font(.system(size: 16))
                    }
                }
                .padding(12)
            }

            // Content
            VStack(alignment: .leading, spacing: 10) {
                Text(artCase.title)
                    .font(.system(size: 17, weight: .semibold, design: .serif))
                    .foregroundStyle(isUnlocked ? AppColors.textPrimary : AppColors.textMuted)
                    .lineLimit(1)

                Text(artCase.goal.rawValue)
                    .font(.system(size: 11, weight: .medium))
                    .tracking(1)
                    .foregroundStyle(AppColors.gold.opacity(isUnlocked ? 0.8 : 0.4))

                HStack(spacing: 12) {
                    // Difficulty stars
                    HStack(spacing: 3) {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= artCase.difficulty.stars ? "star.fill" : "star")
                                .font(.system(size: 10))
                                .foregroundStyle(star <= artCase.difficulty.stars
                                    ? artCase.difficulty.color
                                    : Color.white.opacity(0.2))
                        }
                    }

                    Spacer()

                    // Budget
                    HStack(spacing: 3) {
                        Image(systemName: "dollarsign.circle")
                            .font(.system(size: 11))
                        Text("\(artCase.startingBudget.formatted())")
                            .font(.system(size: 11, design: .monospaced))
                    }
                    .foregroundStyle(AppColors.textMuted)
                }

                // Client snippet
                Text(artCase.clientStory)
                    .font(.system(size: 12))
                    .foregroundStyle(AppColors.textMuted)
                    .lineLimit(2)
                    .italic()
            }
            .padding(16)
        }
        .background(AppColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(isCompleted ? AppColors.success.opacity(0.4) : AppColors.gold.opacity(0.15), lineWidth: 1)
        )
        .opacity(isUnlocked ? 1.0 : 0.55)
        .grayscale(isUnlocked ? 0 : 0.7)
    }
}

// MARK: - Case Preview Sheet

struct CasePreviewSheet: View {
    let artCase: AppraisalCase
    let onStart: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(AppColors.textSecondary)
                    Spacer()
                    Text("CASE BRIEF")
                        .font(.system(size: 13, weight: .semibold))
                        .tracking(3)
                        .foregroundStyle(AppColors.gold)
                    Spacer()
                    Button("Cancel") { dismiss() }.opacity(0)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(AppColors.surface)

                ScrollView {
                    VStack(alignment: .leading, spacing: 28) {
                        // Artwork preview
                        ArtworkThumbnail(artwork: artCase.artwork, style: artCase.artwork.artStyle)
                            .frame(maxWidth: .infinity)
                            .frame(height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(alignment: .bottomLeading) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(artCase.artwork.claimedTitle)
                                        .font(.system(size: 18, weight: .semibold, design: .serif))
                                        .foregroundStyle(.white)
                                    Text("\(artCase.artwork.claimedArtist) · \(artCase.artwork.claimedDate)")
                                        .font(.system(size: 13))
                                        .foregroundStyle(.white.opacity(0.7))
                                    Text("\(artCase.artwork.medium) · \(artCase.artwork.dimensions)")
                                        .font(.system(size: 11))
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(16)
                                .background(LinearGradient(
                                    colors: [.clear, artCase.artwork.darkColor.opacity(0.92)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ))
                            }

                        // Goal
                        VStack(alignment: .leading, spacing: 8) {
                            Label("YOUR ASSIGNMENT", systemImage: "target")
                                .font(.system(size: 11, weight: .semibold))
                                .tracking(2)
                                .foregroundStyle(AppColors.gold)
                            Text(artCase.goal.instruction)
                                .font(.system(size: 15))
                                .foregroundStyle(AppColors.textPrimary)
                        }

                        Divider().background(AppColors.gold.opacity(0.2))

                        // Client
                        VStack(alignment: .leading, spacing: 10) {
                            Label("CLIENT", systemImage: "person.circle")
                                .font(.system(size: 11, weight: .semibold))
                                .tracking(2)
                                .foregroundStyle(AppColors.gold)
                            HStack(alignment: .top, spacing: 14) {
                                ZStack {
                                    Circle().fill(AppColors.surfaceElevated).frame(width: 48, height: 48)
                                    Text(String(artCase.clientName.prefix(1)))
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundStyle(AppColors.gold)
                                }
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(artCase.clientName)
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundStyle(AppColors.textPrimary)
                                    Text(artCase.clientOccupation)
                                        .font(.system(size: 12))
                                        .foregroundStyle(AppColors.textMuted)
                                    Text(""\(artCase.clientStory)"")
                                        .font(.system(size: 13))
                                        .italic()
                                        .foregroundStyle(AppColors.textSecondary)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }

                        Divider().background(AppColors.gold.opacity(0.2))

                        // Scoring info
                        VStack(alignment: .leading, spacing: 12) {
                            Label("ENGAGEMENT TERMS", systemImage: "doc.text")
                                .font(.system(size: 11, weight: .semibold))
                                .tracking(2)
                                .foregroundStyle(AppColors.gold)

                            HStack(spacing: 20) {
                                ScoringRow(label: "Starting Budget", value: "$\(artCase.startingBudget.formatted())", color: AppColors.textSecondary)
                                ScoringRow(label: "Success Fee", value: "+$\(artCase.successPayout.formatted())", color: AppColors.success)
                                ScoringRow(label: "Failure Penalty", value: "-$\(artCase.failurePenalty.formatted())", color: AppColors.failure)
                                ScoringRow(label: "Base XP", value: "\(artCase.baseXP) XP", color: AppColors.gold)
                            }
                        }

                        // Difficulty
                        HStack(spacing: 8) {
                            ForEach(1...5, id: \.self) { star in
                                Image(systemName: star <= artCase.difficulty.stars ? "star.fill" : "star")
                                    .foregroundStyle(star <= artCase.difficulty.stars
                                        ? artCase.difficulty.color
                                        : Color.white.opacity(0.2))
                            }
                            Text(artCase.difficulty.label)
                                .font(.system(size: 13))
                                .foregroundStyle(artCase.difficulty.color)
                        }
                    }
                    .padding(24)
                }

                // Start button
                Button(action: onStart) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("OPEN THE CASE")
                            .tracking(2)
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppColors.background)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(AppColors.gold)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                .padding(24)
            }
        }
    }
}

private struct ScoringRow: View {
    let label: String
    let value: String
    let color: Color
    var body: some View {
        VStack(spacing: 3) {
            Text(value)
                .font(.system(size: 14, weight: .semibold, design: .monospaced))
                .foregroundStyle(color)
            Text(label)
                .font(.system(size: 10))
                .foregroundStyle(AppColors.textMuted)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    LevelSelectView().environment(GameManager())
}
