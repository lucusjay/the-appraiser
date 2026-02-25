// ResearchView.swift
// The Appraiser — Books & Expert Research Panel

import SwiftUI

struct ResearchView: View {
    @Environment(GameManager.self) var game
    @Environment(\.dismiss) private var dismiss
    let artCase: AppraisalCase

    @State private var selectedTab: ResearchTab = .books
    @State private var selectedBook: ReferenceBook? = nil
    @State private var selectedPage: BookPage? = nil
    @State private var showExpertConfirm = false

    enum ResearchTab { case books, expert, auction }

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            VStack(spacing: 0) {
                header
                tabBar
                Divider().background(AppColors.gold.opacity(0.2))

                switch selectedTab {
                case .books:   booksContent
                case .expert:  expertContent
                case .auction: auctionContent
                }
            }
        }
        .sheet(item: $selectedBook) { book in
            BookReaderView(book: book, selectedPage: $selectedPage) {
                game.markBookRead(book)
            }
        }
        .alert("Consult Expert?", isPresented: $showExpertConfirm) {
            Button("Cancel", role: .cancel) {}
            Button("Consult — $\(artCase.expert.cost.formatted())") {
                game.consultExpert()
                selectedTab = .expert
            }
        } message: {
            Text("Consulting \(artCase.expert.name) will cost $\(artCase.expert.cost.formatted()). This will be deducted from your budget.")
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            Button("Done") { dismiss() }
                .foregroundStyle(AppColors.gold)
            Spacer()
            Text("RESEARCH ROOM")
                .font(.system(size: 14, weight: .thin)).tracking(5)
                .foregroundStyle(AppColors.textPrimary)
            Spacer()
            Text("$\(game.roundState.remainingBudget.formatted()) left")
                .font(.system(size: 12, design: .monospaced))
                .foregroundStyle(AppColors.textMuted)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(AppColors.surface)
    }

    // MARK: - Tab Bar

    private var tabBar: some View {
        HStack(spacing: 0) {
            ResearchTabButton(title: "Reference Books", icon: "books.vertical.fill",
                              isSelected: selectedTab == .books, cost: nil) {
                selectedTab = .books
            }
            ResearchTabButton(title: "Ask an Expert", icon: "person.text.rectangle.fill",
                              isSelected: selectedTab == .expert,
                              cost: game.roundState.expertConsulted ? nil : "$\(artCase.expert.cost.formatted())") {
                if game.roundState.expertConsulted {
                    selectedTab = .expert
                } else if game.roundState.remainingBudget >= artCase.expert.cost {
                    showExpertConfirm = true
                } else {
                    selectedTab = .expert // show as locked
                }
            }
            ResearchTabButton(title: "Auction Records", icon: "doc.text.magnifyingglass",
                              isSelected: selectedTab == .auction, cost: nil) {
                selectedTab = .auction
            }
        }
        .background(AppColors.surface)
    }

    // MARK: - Books Content

    private var booksContent: some View {
        HStack(spacing: 0) {
            // Bookshelf
            ScrollView {
                VStack(spacing: 0) {
                    Text("SELECT A VOLUME")
                        .font(.system(size: 10, weight: .semibold)).tracking(3)
                        .foregroundStyle(AppColors.gold)
                        .padding(16)

                    ForEach(artCase.referenceBooks) { book in
                        let isRead = game.roundState.booksRead.contains(book.id)
                        BookSpineRow(book: book, isRead: isRead) {
                            selectedBook = book
                        }
                    }
                }
            }
            .frame(width: 260)
            .background(AppColors.surface)

            Divider().background(AppColors.gold.opacity(0.2))

            // Reading hint
            VStack(spacing: 20) {
                Image(systemName: "books.vertical")
                    .font(.system(size: 48))
                    .foregroundStyle(AppColors.textMuted)
                Text("Select a book to read it.")
                    .font(.system(size: 16))
                    .foregroundStyle(AppColors.textMuted)
                Text("One of the three volumes contains information directly relevant to this case. The others offer broader art historical context.")
                    .font(.system(size: 13))
                    .foregroundStyle(AppColors.textMuted)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    // MARK: - Expert Content

    private var expertContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Expert profile
                HStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(AppColors.surfaceElevated)
                            .frame(width: 72, height: 72)
                        Text(String(artCase.expert.name.prefix(2)))
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(AppColors.gold)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(artCase.expert.name)
                            .font(.system(size: 20, weight: .semibold, design: .serif))
                            .foregroundStyle(AppColors.textPrimary)
                        Text(artCase.expert.title)
                            .font(.system(size: 13))
                            .foregroundStyle(AppColors.textSecondary)
                        Text(artCase.expert.institution)
                            .font(.system(size: 12))
                            .foregroundStyle(AppColors.textMuted)
                        Text("Specialty: \(artCase.expert.specialty)")
                            .font(.system(size: 11))
                            .italic()
                            .foregroundStyle(AppColors.textMuted)
                    }
                }
                .padding(20)
                .background(AppColors.surface)
                .clipShape(RoundedRectangle(cornerRadius: 14))

                if game.roundState.expertConsulted {
                    // Opinion
                    VStack(alignment: .leading, spacing: 12) {
                        Label("EXPERT OPINION", systemImage: "quote.bubble.fill")
                            .font(.system(size: 10, weight: .bold)).tracking(2)
                            .foregroundStyle(AppColors.gold)

                        Text(""\(artCase.expert.opinion)"")
                            .font(.system(size: 16, design: .serif))
                            .italic()
                            .foregroundStyle(AppColors.textPrimary)
                            .lineSpacing(6)

                        Divider().background(AppColors.gold.opacity(0.2))

                        Text("CAVEAT")
                            .font(.system(size: 10, weight: .bold)).tracking(2)
                            .foregroundStyle(AppColors.textMuted)
                        Text(artCase.expert.caveat)
                            .font(.system(size: 14))
                            .foregroundStyle(AppColors.textSecondary)
                            .lineSpacing(4)
                    }
                    .padding(20)
                    .background(AppColors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(AppColors.gold.opacity(0.2), lineWidth: 1))
                } else {
                    // Locked
                    VStack(spacing: 16) {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 32))
                            .foregroundStyle(AppColors.textMuted)
                        Text("Expert opinion not yet requested.")
                            .font(.system(size: 15))
                            .foregroundStyle(AppColors.textMuted)
                        if game.roundState.remainingBudget >= artCase.expert.cost {
                            Button {
                                showExpertConfirm = true
                            } label: {
                                Text("Request Consultation — $\(artCase.expert.cost.formatted())")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(AppColors.background)
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 12)
                                    .background(AppColors.gold)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .buttonStyle(.plain)
                        } else {
                            Text("Insufficient budget to consult this expert.")
                                .font(.system(size: 13))
                                .foregroundStyle(AppColors.failure)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(40)
                    .background(AppColors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
            .padding(24)
        }
        .background(AppColors.background)
    }

    // MARK: - Auction Content

    private var auctionContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Label("AUCTION DATABASE SEARCH", systemImage: "doc.text.magnifyingglass")
                    .font(.system(size: 10, weight: .bold)).tracking(2)
                    .foregroundStyle(AppColors.gold)

                Text("Query: \"\(artCase.artwork.claimedArtist) — comparable works\"")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(AppColors.textMuted)
                    .padding(10)
                    .background(AppColors.surfaceElevated)
                    .clipShape(RoundedRectangle(cornerRadius: 6))

                Divider().background(AppColors.gold.opacity(0.2))

                Text(artCase.auctionRecord)
                    .font(.system(size: 15))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(6)

                Text("This data is for reference only. Auction records provide market context and may help establish provenance, but are not in themselves authentication evidence.")
                    .font(.system(size: 12))
                    .italic()
                    .foregroundStyle(AppColors.textMuted)
                    .padding(12)
                    .background(AppColors.surfaceElevated)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(24)
        }
        .background(AppColors.background)
    }
}

// MARK: - Book Spine Row

private struct BookSpineRow: View {
    let book: ReferenceBook
    let isRead: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(book.coverColor)
                    .frame(width: 10, height: 52)
                VStack(alignment: .leading, spacing: 4) {
                    Text(book.title)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(AppColors.textPrimary)
                        .lineLimit(2)
                    Text(book.author)
                        .font(.system(size: 11))
                        .foregroundStyle(AppColors.textMuted)
                }
                Spacer()
                if isRead {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(AppColors.success)
                        .font(.system(size: 16))
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 11))
                        .foregroundStyle(AppColors.textMuted)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(isRead ? AppColors.success.opacity(0.06) : Color.clear)
        }
        .buttonStyle(.plain)
        Divider().background(Color.white.opacity(0.06))
    }
}

// MARK: - Research Tab Button

private struct ResearchTabButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let cost: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                HStack(spacing: 6) {
                    Image(systemName: icon).font(.system(size: 13))
                    Text(title).font(.system(size: 12, weight: .medium))
                    if let cost = cost {
                        Text(cost).font(.system(size: 10))
                            .padding(.horizontal, 6).padding(.vertical, 2)
                            .background(AppColors.gold.opacity(0.2))
                            .clipShape(Capsule())
                    }
                }
                .foregroundStyle(isSelected ? AppColors.gold : AppColors.textMuted)

                Rectangle()
                    .fill(isSelected ? AppColors.gold : Color.clear)
                    .frame(height: 2)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Book Reader View

struct BookReaderView: View {
    let book: ReferenceBook
    @Binding var selectedPage: BookPage?
    let onRead: () -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var currentPage = 0

    var body: some View {
        ZStack {
            Color(red: 0.97, green: 0.94, blue: 0.88).ignoresSafeArea()

            VStack(spacing: 0) {
                // Book header
                HStack {
                    Button("Close") { dismiss() }
                        .foregroundStyle(Color(red: 0.35, green: 0.25, blue: 0.10))

                    Spacer()

                    VStack(spacing: 2) {
                        Text(book.title)
                            .font(.system(size: 15, weight: .semibold, design: .serif))
                            .foregroundStyle(Color(red: 0.15, green: 0.10, blue: 0.05))
                        Text(book.author)
                            .font(.system(size: 11))
                            .foregroundStyle(Color(red: 0.45, green: 0.35, blue: 0.20))
                    }

                    Spacer()

                    Button("Close") { dismiss() }.opacity(0)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(book.coverColor.opacity(0.25))

                // Spine divider
                Rectangle().fill(book.coverColor.opacity(0.5)).frame(height: 2)

                // Page content
                TabView(selection: $currentPage) {
                    // Synopsis page
                    BookPageView(
                        title: "About This Volume",
                        content: book.synopsis,
                        pageNumber: "Preface",
                        bookColor: book.coverColor
                    )
                    .tag(0)

                    // Content pages
                    ForEach(Array(book.pages.enumerated()), id: \.offset) { index, page in
                        BookPageView(
                            title: page.title,
                            content: page.content,
                            pageNumber: "Chapter \(index + 1)",
                            bookColor: book.coverColor
                        )
                        .tag(index + 1)
                    }
                }
                .tabViewStyle(.page)
                .onAppear { onRead() }

                // Page dots
                HStack(spacing: 8) {
                    ForEach(0..<(book.pages.count + 1), id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? book.coverColor : book.coverColor.opacity(0.3))
                            .frame(width: 7, height: 7)
                    }
                }
                .padding(.vertical, 16)
            }
        }
    }
}

private struct BookPageView: View {
    let title: String
    let content: String
    let pageNumber: String
    let bookColor: Color

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(pageNumber)
                        .font(.system(size: 11, weight: .medium))
                        .tracking(2)
                        .foregroundStyle(bookColor.opacity(0.7))
                    Text(title)
                        .font(.system(size: 22, weight: .bold, design: .serif))
                        .foregroundStyle(Color(red: 0.12, green: 0.08, blue: 0.04))
                }

                Rectangle().fill(bookColor.opacity(0.4)).frame(height: 1)

                Text(content)
                    .font(.system(size: 15, design: .serif))
                    .foregroundStyle(Color(red: 0.20, green: 0.14, blue: 0.08))
                    .lineSpacing(8)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(32)
        }
        .background(Color(red: 0.97, green: 0.94, blue: 0.88))
    }
}

#Preview {
    ResearchView(artCase: LevelData.all[0]).environment(GameManager())
}
