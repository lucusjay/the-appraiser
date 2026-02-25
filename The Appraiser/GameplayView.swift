// GameplayView.swift
// The Appraiser — Main Gameplay Screen

import SwiftUI

struct GameplayView: View {
    @Environment(GameManager.self) var game
    let artCase: AppraisalCase

    @State private var showResearch = false
    @State private var showSubmit = false
    @State private var activeTab: SideTab = .tools
    @State private var expandedFinding: ToolFinding? = nil

    enum SideTab { case tools, notebook }

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                topBar
                mainContent
            }
        }
        .sheet(isPresented: $showResearch) {
            ResearchView(artCase: artCase)
        }
        .sheet(isPresented: $showSubmit) {
            SubmitAppraisalView(artCase: artCase) { showSubmit = false }
        }
        .sheet(item: $expandedFinding) { finding in
            FindingDetailSheet(finding: finding)
        }
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack(spacing: 16) {
            // Back
            Button {
                game.goToLevelSelect()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(AppColors.textMuted)
                    .frame(width: 36, height: 36)
                    .background(AppColors.surfaceElevated)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)

            // Case title
            VStack(alignment: .leading, spacing: 1) {
                Text("CASE \(artCase.levelNumber)")
                    .font(.system(size: 10, weight: .semibold)).tracking(3)
                    .foregroundStyle(AppColors.gold)
                Text(artCase.title)
                    .font(.system(size: 16, weight: .semibold, design: .serif))
                    .foregroundStyle(AppColors.textPrimary)
            }

            Spacer()

            // Goal
            Text(artCase.goal.rawValue)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(AppColors.textSecondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(AppColors.surfaceElevated)
                .clipShape(Capsule())

            Spacer()

            // Budget
            BudgetDisplay(
                remaining: game.roundState.remainingBudget,
                total: artCase.startingBudget
            )

            // Research button
            Button {
                showResearch = true
            } label: {
                Label("Research", systemImage: "books.vertical.fill")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(AppColors.gold)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(AppColors.gold.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(AppColors.gold.opacity(0.3), lineWidth: 1))
            }
            .buttonStyle(.plain)

            // Submit
            Button {
                showSubmit = true
            } label: {
                Label("Submit", systemImage: "checkmark.seal.fill")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppColors.background)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(AppColors.gold)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(AppColors.surface)
        .overlay(alignment: .bottom) {
            Rectangle().fill(AppColors.gold.opacity(0.15)).frame(height: 1)
        }
    }

    // MARK: - Main Content

    private var mainContent: some View {
        HStack(spacing: 0) {
            // Left: Artwork
            artworkPanel
                .frame(maxWidth: .infinity)

            // Divider
            Rectangle().fill(AppColors.gold.opacity(0.15)).frame(width: 1)

            // Right: Tools + Notebook
            sidePanel
                .frame(width: 340)
        }
    }

    // MARK: - Artwork Panel

    private var artworkPanel: some View {
        VStack(spacing: 0) {
            // Tool selector bar
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    // Normal view
                    ToolChipButton(
                        label: "Normal View",
                        icon: "eye",
                        cost: nil,
                        isActive: game.roundState.activeToolOverlay == nil,
                        isUsed: false,
                        canAfford: true
                    ) {
                        game.setActiveOverlay(nil)
                    }

                    ForEach(ToolType.allCases) { tool in
                        let used = game.roundState.usedTools.contains(tool)
                        let active = game.roundState.activeToolOverlay == tool
                        let canAfford = game.canUseTool(tool)

                        ToolChipButton(
                            label: tool.rawValue,
                            icon: tool.icon,
                            cost: used ? nil : (tool.cost > 0 ? tool.costLabel : nil),
                            isActive: active,
                            isUsed: used,
                            canAfford: canAfford || used
                        ) {
                            if used {
                                game.setActiveOverlay(tool)
                            } else if canAfford {
                                game.useTool(tool)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            }
            .background(AppColors.surface.opacity(0.5))

            // Artwork canvas
            ZStack {
                let activeOverlay = game.roundState.activeToolOverlay
                let finding = activeOverlay.flatMap { artCase.toolFindings[$0] }

                ArtworkDisplayView(
                    artwork: artCase.artwork,
                    activeOverlay: activeOverlay,
                    finding: finding
                )

                // Current tool info overlay (bottom)
                if let overlay = activeOverlay,
                   let finding = artCase.toolFindings[overlay] {
                    VStack {
                        Spacer()
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: overlay.icon)
                                .font(.system(size: 16))
                                .foregroundStyle(AppColors.gold)
                                .frame(width: 36, height: 36)
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                            VStack(alignment: .leading, spacing: 3) {
                                Text(finding.headline)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(.white)
                                Text(finding.detail.prefix(100) + "…")
                                    .font(.system(size: 11))
                                    .foregroundStyle(Color.white.opacity(0.7))
                                    .lineLimit(2)
                            }
                            Spacer()
                            Button {
                                expandedFinding = finding
                            } label: {
                                Text("Read More")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundStyle(AppColors.gold)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(14)
                        .background(Color.black.opacity(0.8))
                        .overlay(alignment: .top) {
                            Rectangle().fill(AppColors.gold.opacity(0.5)).frame(height: 1)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Side Panel

    private var sidePanel: some View {
        VStack(spacing: 0) {
            // Tab selector
            HStack(spacing: 0) {
                TabButton(title: "Tools", isSelected: activeTab == .tools) {
                    activeTab = .tools
                }
                TabButton(title: "Notebook", isSelected: activeTab == .notebook) {
                    activeTab = .notebook
                }
            }
            .background(AppColors.surface)

            Divider().background(AppColors.gold.opacity(0.2))

            switch activeTab {
            case .tools:
                toolsTab
            case .notebook:
                notebookTab
            }
        }
    }

    // MARK: - Tools Tab

    private var toolsTab: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Client brief
                VStack(alignment: .leading, spacing: 10) {
                    Label("CLIENT BRIEF", systemImage: "person.circle")
                        .font(.system(size: 10, weight: .bold)).tracking(2)
                        .foregroundStyle(AppColors.gold)
                    Text(artCase.clientName)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(AppColors.textPrimary)
                    Text(artCase.clientOccupation)
                        .font(.system(size: 11))
                        .foregroundStyle(AppColors.textMuted)
                    Text(""\(artCase.clientStory)"")
                        .font(.system(size: 12))
                        .italic()
                        .foregroundStyle(AppColors.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(16)
                .background(AppColors.surfaceElevated)

                Divider().background(AppColors.gold.opacity(0.15))

                // Artwork details
                VStack(alignment: .leading, spacing: 8) {
                    Label("ARTWORK", systemImage: "photo.artframe")
                        .font(.system(size: 10, weight: .bold)).tracking(2)
                        .foregroundStyle(AppColors.gold)
                    InfoRow(label: "Title", value: artCase.artwork.claimedTitle)
                    InfoRow(label: "Artist", value: artCase.artwork.claimedArtist)
                    InfoRow(label: "Date", value: artCase.artwork.claimedDate)
                    InfoRow(label: "Medium", value: artCase.artwork.medium)
                    InfoRow(label: "Size", value: artCase.artwork.dimensions)
                }
                .padding(16)

                Divider().background(AppColors.gold.opacity(0.15))

                // Available tools
                VStack(alignment: .leading, spacing: 12) {
                    Label("EXAMINATION TOOLS", systemImage: "wrench.and.screwdriver")
                        .font(.system(size: 10, weight: .bold)).tracking(2)
                        .foregroundStyle(AppColors.gold)

                    ForEach(ToolType.allCases) { tool in
                        let used = game.roundState.usedTools.contains(tool)
                        let canAfford = game.canUseTool(tool)

                        ToolListRow(
                            tool: tool,
                            isUsed: used,
                            canAfford: canAfford
                        ) {
                            if used {
                                game.setActiveOverlay(tool)
                            } else if canAfford {
                                game.useTool(tool)
                            }
                        }
                    }
                }
                .padding(16)
            }
        }
        .background(AppColors.background)
    }

    // MARK: - Notebook Tab

    private var notebookTab: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("FINDINGS NOTEBOOK")
                    .font(.system(size: 10, weight: .bold)).tracking(3)
                    .foregroundStyle(AppColors.gold)
                    .padding(.top, 16)
                    .padding(.horizontal, 16)

                if game.roundState.collectedFindings.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "note.text")
                            .font(.system(size: 36))
                            .foregroundStyle(AppColors.textMuted)
                        Text("Use examination tools to collect findings.\nYour notes will appear here.")
                            .font(.system(size: 13))
                            .foregroundStyle(AppColors.textMuted)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(40)
                } else {
                    ForEach(game.roundState.collectedFindings) { finding in
                        FindingCard(finding: finding) {
                            expandedFinding = finding
                        }
                        .padding(.horizontal, 16)
                    }
                }

                // Expert note if consulted
                if game.roundState.expertConsulted {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("EXPERT OPINION", systemImage: "person.text.rectangle")
                            .font(.system(size: 10, weight: .bold)).tracking(2)
                            .foregroundStyle(AppColors.gold)
                        Text(artCase.expert.name)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(AppColors.textPrimary)
                        Text(artCase.expert.title)
                            .font(.system(size: 11))
                            .foregroundStyle(AppColors.textMuted)
                        Text(""\(artCase.expert.opinion)"")
                            .font(.system(size: 12))
                            .italic()
                            .foregroundStyle(AppColors.textSecondary)
                        Text("Note: \(artCase.expert.caveat)")
                            .font(.system(size: 11))
                            .foregroundStyle(AppColors.textMuted)
                    }
                    .padding(14)
                    .background(AppColors.surfaceElevated)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(AppColors.gold.opacity(0.2), lineWidth: 1))
                    .padding(.horizontal, 16)
                }

                // Books read
                let booksRead = artCase.referenceBooks.filter { game.roundState.booksRead.contains($0.id) }
                if !booksRead.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("RESEARCH NOTES", systemImage: "books.vertical")
                            .font(.system(size: 10, weight: .bold)).tracking(2)
                            .foregroundStyle(AppColors.gold)
                        ForEach(booksRead) { book in
                            HStack(spacing: 10) {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(book.coverColor)
                                    .frame(width: 8, height: 40)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(book.title)
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundStyle(AppColors.textPrimary)
                                    Text(book.synopsis.prefix(80) + "…")
                                        .font(.system(size: 11))
                                        .foregroundStyle(AppColors.textMuted)
                                }
                            }
                        }
                    }
                    .padding(14)
                    .background(AppColors.surfaceElevated)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 16)
                }

                Spacer().frame(height: 20)
            }
        }
        .background(AppColors.background)
    }
}

// MARK: - Supporting Views

private struct BudgetDisplay: View {
    let remaining: Int
    let total: Int
    var fraction: Double { Double(remaining) / Double(total) }
    var color: Color {
        fraction > 0.5 ? AppColors.success : fraction > 0.25 ? .orange : AppColors.failure
    }
    var body: some View {
        VStack(alignment: .trailing, spacing: 3) {
            HStack(spacing: 4) {
                Image(systemName: "dollarsign.circle.fill")
                    .font(.system(size: 12))
                    .foregroundStyle(color)
                Text("$\(remaining.formatted())")
                    .font(.system(size: 14, weight: .semibold, design: .monospaced))
                    .foregroundStyle(color)
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.white.opacity(0.1)).frame(height: 4)
                    Capsule().fill(color).frame(width: geo.size.width * max(0, fraction), height: 4)
                }
            }.frame(width: 80, height: 4)
            Text("Budget remaining")
                .font(.system(size: 9)).foregroundStyle(AppColors.textMuted)
        }
    }
}

private struct ToolChipButton: View {
    let label: String
    let icon: String
    let cost: String?
    let isActive: Bool
    let isUsed: Bool
    let canAfford: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 5) {
                Image(systemName: isUsed ? icon : icon)
                    .font(.system(size: 12))
                Text(label)
                    .font(.system(size: 11, weight: .medium))
                if let cost = cost {
                    Text(cost)
                        .font(.system(size: 10))
                        .opacity(0.7)
                }
                if isUsed {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(AppColors.success)
                }
            }
            .foregroundStyle(isActive ? AppColors.background : (canAfford ? AppColors.textPrimary : AppColors.textMuted))
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(isActive ? AppColors.gold : (isUsed ? AppColors.success.opacity(0.15) : AppColors.surfaceElevated))
            .clipShape(Capsule())
            .overlay(Capsule().stroke(isActive ? AppColors.gold : AppColors.gold.opacity(0.2), lineWidth: 1))
        }
        .buttonStyle(.plain)
        .opacity(canAfford || isUsed ? 1.0 : 0.5)
    }
}

private struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .tracking(1)
                .foregroundStyle(isSelected ? AppColors.gold : AppColors.textMuted)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .overlay(alignment: .bottom) {
                    if isSelected {
                        Rectangle().fill(AppColors.gold).frame(height: 2)
                    }
                }
        }
        .buttonStyle(.plain)
    }
}

private struct InfoRow: View {
    let label: String
    let value: String
    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .font(.system(size: 11))
                .foregroundStyle(AppColors.textMuted)
                .frame(width: 60, alignment: .leading)
            Text(value)
                .font(.system(size: 12))
                .foregroundStyle(AppColors.textSecondary)
            Spacer()
        }
    }
}

private struct ToolListRow: View {
    let tool: ToolType
    let isUsed: Bool
    let canAfford: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: tool.icon)
                    .font(.system(size: 18))
                    .foregroundStyle(isUsed ? AppColors.success : AppColors.gold)
                    .frame(width: 32)

                VStack(alignment: .leading, spacing: 2) {
                    Text(tool.rawValue)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(AppColors.textPrimary)
                    Text(tool.description)
                        .font(.system(size: 11))
                        .foregroundStyle(AppColors.textMuted)
                        .lineLimit(2)
                }

                Spacer()

                if isUsed {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(AppColors.success)
                } else {
                    Text(tool.costLabel)
                        .font(.system(size: 11, weight: .medium, design: .monospaced))
                        .foregroundStyle(canAfford ? AppColors.gold : AppColors.failure)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background((canAfford ? AppColors.gold : AppColors.failure).opacity(0.12))
                        .clipShape(Capsule())
                }
            }
            .padding(12)
            .background(AppColors.surfaceElevated)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
        .opacity(canAfford || isUsed ? 1.0 : 0.55)
    }
}

private struct FindingCard: View {
    let finding: ToolFinding
    let onExpand: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: finding.tool.icon)
                    .font(.system(size: 12))
                    .foregroundStyle(AppColors.gold)
                Text(finding.tool.rawValue.uppercased())
                    .font(.system(size: 9, weight: .bold)).tracking(2)
                    .foregroundStyle(AppColors.gold)
                Spacer()
                Button(action: onExpand) {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .font(.system(size: 11))
                        .foregroundStyle(AppColors.textMuted)
                }
                .buttonStyle(.plain)
            }
            Text(finding.headline)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(AppColors.textPrimary)
            Text(finding.detail.prefix(140) + "…")
                .font(.system(size: 11))
                .foregroundStyle(AppColors.textSecondary)
                .lineLimit(3)
        }
        .padding(12)
        .background(AppColors.surfaceElevated)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(AppColors.gold.opacity(0.15), lineWidth: 1))
    }
}

struct FindingDetailSheet: View {
    let finding: ToolFinding
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Label(finding.tool.rawValue.uppercased(), systemImage: finding.tool.icon)
                        .font(.system(size: 12, weight: .bold)).tracking(2)
                        .foregroundStyle(AppColors.gold)
                    Spacer()
                    Button("Done") { dismiss() }
                        .foregroundStyle(AppColors.gold)
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)

                Divider().background(AppColors.gold.opacity(0.2)).padding(.horizontal, 24)

                Text(finding.headline)
                    .font(.system(size: 22, weight: .semibold, design: .serif))
                    .foregroundStyle(AppColors.textPrimary)
                    .padding(.horizontal, 24)

                ScrollView {
                    Text(finding.detail)
                        .font(.system(size: 15))
                        .foregroundStyle(AppColors.textSecondary)
                        .lineSpacing(6)
                        .padding(.horizontal, 24)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    GameplayView(artCase: LevelData.all[0]).environment(GameManager())
}
