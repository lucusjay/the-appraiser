// GameModels.swift
// The Appraiser — Core Data Models

import Foundation
import SwiftUI

// MARK: - Enums

enum AppraisalGoal: String, Codable, CaseIterable {
    case authenticateRealOrFake = "Authenticate: Real or Fake?"
    case identifyArtist = "Identify the Artist"
    case identifyPeriod = "Identify the Period / Movement"
    case identifyDecade = "Identify the Decade"
    case fullAttribution = "Full Attribution"
    case assessCondition = "Assess Authenticity & Condition"

    var instruction: String {
        switch self {
        case .authenticateRealOrFake:
            return "Your client wants to know: is this painting genuine, or is it a forgery? Use every tool at your disposal to find out."
        case .identifyArtist:
            return "The artist of this work is unknown or disputed. Use your investigative tools and research to identify who painted it."
        case .identifyPeriod:
            return "Identify the artistic movement or historical period this work belongs to."
        case .identifyDecade:
            return "Narrow down the creation date — your client needs you to get within a decade."
        case .fullAttribution:
            return "Provide complete attribution: artist, movement, and approximate date of creation."
        case .assessCondition:
            return "Determine the true nature of this work — is it authentic, heavily restored, overpainted, or an outright forgery?"
        }
    }
}

enum ToolType: String, CaseIterable, Identifiable, Codable, Hashable {
    case magnifyingGlass = "Magnifying Glass"
    case uvLight = "UV Light"
    case xRay = "X-Ray"
    case infrared = "Infrared Reflectography"
    case chemicalAnalysis = "Chemical Analysis"
    case provenanceSearch = "Provenance Search"
    case canvasDating = "Canvas & Support Dating"

    var id: String { rawValue }

    var cost: Int {
        switch self {
        case .magnifyingGlass: return 0
        case .uvLight:         return 500
        case .xRay:            return 1200
        case .infrared:        return 1000
        case .chemicalAnalysis: return 1800
        case .provenanceSearch: return 600
        case .canvasDating:    return 2200
        }
    }

    var icon: String {
        switch self {
        case .magnifyingGlass:  return "magnifyingglass"
        case .uvLight:          return "flashlight.on.fill"
        case .xRay:             return "camera.filters"
        case .infrared:         return "thermometer.medium"
        case .chemicalAnalysis: return "flask.fill"
        case .provenanceSearch: return "doc.text.magnifyingglass"
        case .canvasDating:     return "calendar.badge.clock"
        }
    }

    var costLabel: String {
        cost == 0 ? "Free" : "$\(cost.formatted())"
    }

    var description: String {
        switch self {
        case .magnifyingGlass:
            return "Close-up examination of brushwork, surface texture, craquelure, and signatures."
        case .uvLight:
            return "UV fluorescence reveals restorations, varnish age, retouching, and surface repairs invisible to the naked eye."
        case .xRay:
            return "X-radiography penetrates paint layers to reveal underdrawings, canvas structure, and pentimento."
        case .infrared:
            return "Infrared imaging reveals preliminary sketches and compositional revisions beneath the paint surface."
        case .chemicalAnalysis:
            return "Identifies specific pigments, binders, and varnishes to confirm period-appropriate materials."
        case .provenanceSearch:
            return "Searches auction records, exhibition catalogs, and documented ownership history."
        case .canvasDating:
            return "Dendrochronology, carbon dating, and fiber analysis of the canvas or panel support."
        }
    }
}

enum Difficulty: Int, Codable, Comparable {
    case apprentice   = 1
    case journeyman   = 2
    case adept        = 3
    case expert       = 4
    case grandmaster  = 5

    static func < (lhs: Difficulty, rhs: Difficulty) -> Bool { lhs.rawValue < rhs.rawValue }

    var label: String {
        switch self {
        case .apprentice:  return "Apprentice"
        case .journeyman:  return "Journeyman"
        case .adept:       return "Adept"
        case .expert:      return "Expert"
        case .grandmaster: return "Grand Master"
        }
    }

    var stars: Int { rawValue }

    var color: Color {
        switch self {
        case .apprentice:  return .green
        case .journeyman:  return .teal
        case .adept:       return .orange
        case .expert:      return .red
        case .grandmaster: return .purple
        }
    }
}

// MARK: - Data Structures

struct ToolFinding: Identifiable {
    let id = UUID()
    let tool: ToolType
    let headline: String
    let detail: String
    let overlayStyle: OverlayStyle

    enum OverlayStyle {
        case normal, magnified, uvRevealed, xrayRevealed, infraredRevealed, chemicalMapped, documentView
    }
}

struct BookPage: Identifiable {
    let id = UUID()
    let title: String
    let content: String
}

struct ReferenceBook: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let coverColor: Color
    let synopsis: String
    let pages: [BookPage]
    let isRelevant: Bool
}

struct ExpertProfile: Identifiable {
    let id = UUID()
    let name: String
    let title: String
    let institution: String
    let specialty: String
    let opinion: String
    let caveat: String
    let cost: Int
}

struct ArtworkInfo {
    let claimedTitle: String
    let claimedArtist: String
    let claimedDate: String
    let medium: String
    let dimensions: String
    let primaryColor: Color
    let accentColor: Color
    let darkColor: Color
    let artStyle: ArtStyle

    enum ArtStyle: String {
        case swirling, gestural, classical, interiorScene, abstractField, portraitBust, ruralLandscape, dramaticScene
    }
}

struct CorrectAnswer {
    let shortAnswer: String       // e.g. "Forgery" or "Claude Monet"
    let fullAnswer: String        // Complete answer text shown in results
    let educationalExplanation: String  // Why — the learning content
}

struct AppraisalCase: Identifiable {
    let id: Int
    let levelNumber: Int
    let title: String
    let difficulty: Difficulty
    let goal: AppraisalGoal
    let startingBudget: Int

    // Client
    let clientName: String
    let clientOccupation: String
    let clientStory: String

    // Artwork
    let artwork: ArtworkInfo

    // Investigation
    let toolFindings: [ToolType: ToolFinding]
    let referenceBooks: [ReferenceBook]
    let expert: ExpertProfile
    let auctionRecord: String

    // Answer
    let correctAnswer: CorrectAnswer
    let choices: [String]
    let correctChoiceIndex: Int

    // Scoring
    let successPayout: Int
    let failurePenalty: Int
    let baseXP: Int
}

// MARK: - Player Progress

struct PlayerProgress: Codable {
    var totalXP: Int = 0
    var totalMoneyEarned: Int = 0
    var completedLevels: [Int] = []
    var highestUnlockedLevel: Int = 1

    var rank: AppraiserRank {
        switch totalXP {
        case 0..<200:    return .apprentice
        case 200..<600:  return .junior
        case 600..<1400: return .senior
        case 1400..<2800: return .master
        default:          return .grandMaster
        }
    }

    var rankProgressFraction: Double {
        let (lo, hi) = rank.xpRange
        guard hi > lo else { return 1.0 }
        return min(1.0, Double(totalXP - lo) / Double(hi - lo))
    }

    var nextUnlockedLevel: Int {
        (completedLevels.max() ?? 0) + 1
    }

    enum AppraiserRank: String, Codable {
        case apprentice  = "Apprentice Appraiser"
        case junior      = "Junior Appraiser"
        case senior      = "Senior Appraiser"
        case master      = "Master Appraiser"
        case grandMaster = "Grand Master Appraiser"

        var xpRange: (Int, Int) {
            switch self {
            case .apprentice:  return (0,    200)
            case .junior:      return (200,  600)
            case .senior:      return (600,  1400)
            case .master:      return (1400, 2800)
            case .grandMaster: return (2800, 2800)
            }
        }

        var badge: String {
            switch self {
            case .apprentice:  return "magnifyingglass"
            case .junior:      return "doc.text.magnifyingglass"
            case .senior:      return "building.columns"
            case .master:      return "scalemass"
            case .grandMaster: return "crown"
            }
        }
    }
}

// MARK: - Round State

struct RoundState {
    var budget: Int
    var spentAmount: Int = 0
    var usedTools: Set<ToolType> = []
    var collectedFindings: [ToolFinding] = []
    var booksRead: Set<UUID> = []
    var expertConsulted: Bool = false
    var selectedChoiceIndex: Int? = nil
    var activeToolOverlay: ToolType? = nil
    var phase: Phase = .investigation

    var remainingBudget: Int { budget - spentAmount }
    var canAfford: (ToolType) -> Bool { { self.remainingBudget >= $0.cost } }

    enum Phase { case investigation, submitting, complete }

    mutating func activate(tool: ToolType, finding: ToolFinding) {
        guard !usedTools.contains(tool) else {
            activeToolOverlay = tool
            return
        }
        usedTools.insert(tool)
        spentAmount += tool.cost
        collectedFindings.append(finding)
        activeToolOverlay = tool
    }
}

// MARK: - Round Result

struct RoundResult {
    let levelID: Int
    let wasCorrect: Bool
    let moneyDelta: Int
    let xpEarned: Int
    let toolsUsed: [ToolType]
    let spentOnTools: Int
    let playerChoice: String
    let correctAnswer: String
    let explanation: String
}
