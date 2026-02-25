// ArtworkDisplayView.swift
// The Appraiser — Artwork Placeholder + Tool Overlay Views
// Replace placeholder visuals with real artwork images when available.

import SwiftUI

// MARK: - Main Artwork Display (with tool overlay support)

struct ArtworkDisplayView: View {
    let artwork: ArtworkInfo
    let activeOverlay: ToolType?
    let finding: ToolFinding?

    var body: some View {
        ZStack {
            // Base artwork
            ArtworkCanvas(artwork: artwork)

            // Tool overlay
            if let overlay = activeOverlay, let finding = finding {
                ToolOverlayView(tool: overlay, finding: finding, artwork: artwork)
                    .transition(.opacity.animation(.easeInOut(duration: 0.4)))
            }
        }
        .animation(.easeInOut(duration: 0.35), value: activeOverlay)
    }
}

// MARK: - Artwork Canvas (placeholder procedural art)

struct ArtworkCanvas: View {
    let artwork: ArtworkInfo

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Background
                LinearGradient(
                    colors: [artwork.primaryColor, artwork.darkColor],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                // Style-specific elements
                styleLayer(size: geo.size)

                // Frame vignette
                RadialGradient(
                    colors: [.clear, .black.opacity(0.5)],
                    center: .center,
                    startRadius: min(geo.size.width, geo.size.height) * 0.4,
                    endRadius: min(geo.size.width, geo.size.height) * 0.8
                )

                // Artwork title watermark
                VStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text(artwork.claimedTitle)
                            .font(.system(size: 13, weight: .medium, design: .serif))
                            .foregroundStyle(.white.opacity(0.6))
                        Text("\(artwork.claimedArtist) · \(artwork.claimedDate)")
                            .font(.system(size: 10))
                            .foregroundStyle(.white.opacity(0.4))
                        Text("[Placeholder — Replace with real artwork]")
                            .font(.system(size: 9))
                            .foregroundStyle(.white.opacity(0.25))
                    }
                    .padding(.bottom, 16)
                }
            }
        }
    }

    @ViewBuilder
    private func styleLayer(size: CGSize) -> some View {
        switch artwork.artStyle {
        case .swirling:
            SwirlingStyle(primary: artwork.primaryColor, accent: artwork.accentColor, size: size)
        case .gestural:
            GesturalStyle(primary: artwork.primaryColor, accent: artwork.accentColor, size: size)
        case .classical:
            ClassicalStyle(primary: artwork.primaryColor, accent: artwork.accentColor, size: size)
        case .interiorScene:
            InteriorStyle(primary: artwork.primaryColor, accent: artwork.accentColor, size: size)
        case .abstractField:
            AbstractFieldStyle(primary: artwork.primaryColor, accent: artwork.accentColor, dark: artwork.darkColor, size: size)
        case .portraitBust:
            PortraitStyle(primary: artwork.primaryColor, accent: artwork.accentColor, size: size)
        case .ruralLandscape:
            LandscapeStyle(primary: artwork.primaryColor, accent: artwork.accentColor, size: size)
        case .dramaticScene:
            DramaticStyle(primary: artwork.primaryColor, accent: artwork.accentColor, dark: artwork.darkColor, size: size)
        }
    }
}

// MARK: - Style Layers

private struct SwirlingStyle: View {
    let primary, accent: Color; let size: CGSize
    var body: some View {
        Canvas { ctx, s in
            for i in 0..<12 {
                let t = Double(i) / 12.0
                let cx = s.width * (0.3 + 0.4 * sin(t * .pi * 2))
                let cy = s.height * (0.3 + 0.4 * cos(t * .pi * 1.7))
                let r = s.width * 0.08 * (0.5 + t)
                let path = Path(ellipseIn: CGRect(x: cx - r, y: cy - r, width: r * 2, height: r * 2))
                ctx.stroke(path, with: .color(i.isMultiple(of: 2) ? primary : accent, opacity: 0.25), lineWidth: 3)
            }
        }
    }
}

private struct GesturalStyle: View {
    let primary, accent: Color; let size: CGSize
    var body: some View {
        Canvas { ctx, s in
            for i in 0..<20 {
                let x = s.width * Double(i) / 20
                var p = Path()
                p.move(to: CGPoint(x: x, y: 0))
                p.addCurve(
                    to: CGPoint(x: x + s.width * 0.05, y: s.height),
                    control1: CGPoint(x: x + s.width * 0.1, y: s.height * 0.3),
                    control2: CGPoint(x: x - s.width * 0.05, y: s.height * 0.7)
                )
                ctx.stroke(p, with: .color(i.isMultiple(of: 3) ? primary : accent, opacity: 0.3), lineWidth: 2)
            }
        }
    }
}

private struct ClassicalStyle: View {
    let primary, accent: Color; let size: CGSize
    var body: some View {
        Canvas { ctx, s in
            // Columns suggestion
            for i in 0..<5 {
                let x = s.width * (0.1 + Double(i) * 0.2)
                let rect = CGRect(x: x - 8, y: s.height * 0.15, width: 16, height: s.height * 0.7)
                ctx.fill(Path(rect), with: .color(accent, opacity: 0.12))
            }
            // Arch
            var arch = Path()
            arch.addArc(center: CGPoint(x: s.width / 2, y: s.height * 0.3),
                        radius: s.width * 0.35, startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
            ctx.stroke(arch, with: .color(accent, opacity: 0.3), lineWidth: 2)
        }
    }
}

private struct InteriorStyle: View {
    let primary, accent: Color; let size: CGSize
    var body: some View {
        Canvas { ctx, s in
            // Window light shaft
            var shaft = Path()
            shaft.move(to: CGPoint(x: s.width * 0.1, y: 0))
            shaft.addLine(to: CGPoint(x: s.width * 0.4, y: s.height * 0.8))
            shaft.addLine(to: CGPoint(x: s.width * 0.55, y: s.height * 0.8))
            shaft.addLine(to: CGPoint(x: s.width * 0.35, y: 0))
            shaft.closeSubpath()
            ctx.fill(shaft, with: .color(accent, opacity: 0.18))
            // Floor tiles
            for row in 0..<4 {
                for col in 0..<6 {
                    let x = s.width * (Double(col) / 5.0)
                    let y = s.height * (0.65 + Double(row) * 0.1)
                    let rect = CGRect(x: x, y: y, width: s.width / 5 - 2, height: s.height * 0.08)
                    ctx.stroke(Path(rect), with: .color(accent, opacity: 0.12), lineWidth: 1)
                }
            }
        }
    }
}

private struct AbstractFieldStyle: View {
    let primary, accent, dark: Color; let size: CGSize
    var body: some View {
        Canvas { ctx, s in
            // Color field blocks with soft edges
            let rects: [(CGRect, Color, Double)] = [
                (CGRect(x: 0, y: 0, width: s.width, height: s.height * 0.12), dark, 0.8),
                (CGRect(x: 0, y: s.height * 0.10, width: s.width, height: s.height * 0.55), primary, 0.85),
                (CGRect(x: 0, y: s.height * 0.62, width: s.width, height: s.height * 0.20), accent, 0.7),
                (CGRect(x: 0, y: s.height * 0.80, width: s.width, height: s.height * 0.20), dark, 0.9)
            ]
            for (rect, color, opacity) in rects {
                ctx.fill(Path(rect), with: .color(color, opacity: opacity))
            }
        }
    }
}

private struct PortraitStyle: View {
    let primary, accent: Color; let size: CGSize
    var body: some View {
        Canvas { ctx, s in
            // Oval face shape
            let faceRect = CGRect(
                x: s.width * 0.3, y: s.height * 0.1,
                width: s.width * 0.4, height: s.height * 0.5
            )
            ctx.fill(Path(ellipseIn: faceRect), with: .color(accent, opacity: 0.35))
            // Shoulders
            var shoulders = Path()
            shoulders.move(to: CGPoint(x: s.width * 0.15, y: s.height * 0.95))
            shoulders.addCurve(
                to: CGPoint(x: s.width * 0.85, y: s.height * 0.95),
                control1: CGPoint(x: s.width * 0.2, y: s.height * 0.55),
                control2: CGPoint(x: s.width * 0.8, y: s.height * 0.55)
            )
            ctx.stroke(shoulders, with: .color(accent, opacity: 0.3), lineWidth: 3)
        }
    }
}

private struct LandscapeStyle: View {
    let primary, accent: Color; let size: CGSize
    var body: some View {
        Canvas { ctx, s in
            // Sky
            ctx.fill(Path(CGRect(x: 0, y: 0, width: s.width, height: s.height * 0.4)),
                     with: .color(accent, opacity: 0.4))
            // Hills
            var hills = Path()
            hills.move(to: CGPoint(x: 0, y: s.height * 0.55))
            hills.addCurve(
                to: CGPoint(x: s.width, y: s.height * 0.50),
                control1: CGPoint(x: s.width * 0.25, y: s.height * 0.30),
                control2: CGPoint(x: s.width * 0.75, y: s.height * 0.65)
            )
            hills.addLine(to: CGPoint(x: s.width, y: s.height))
            hills.addLine(to: CGPoint(x: 0, y: s.height))
            hills.closeSubpath()
            ctx.fill(hills, with: .color(primary, opacity: 0.6))
        }
    }
}

private struct DramaticStyle: View {
    let primary, accent, dark: Color; let size: CGSize
    var body: some View {
        Canvas { ctx, s in
            // Near-black background
            ctx.fill(Path(CGRect(x: 0, y: 0, width: s.width, height: s.height)),
                     with: .color(dark, opacity: 0.85))
            // Light shaft from upper left
            var shaft = Path()
            shaft.move(to: CGPoint(x: s.width * 0.05, y: 0))
            shaft.addLine(to: CGPoint(x: s.width * 0.55, y: s.height * 0.7))
            shaft.addLine(to: CGPoint(x: s.width * 0.70, y: s.height * 0.7))
            shaft.addLine(to: CGPoint(x: s.width * 0.30, y: 0))
            shaft.closeSubpath()
            ctx.fill(shaft, with: .color(accent, opacity: 0.22))
        }
    }
}

// MARK: - Tool Overlay Views

struct ToolOverlayView: View {
    let tool: ToolType
    let finding: ToolFinding
    let artwork: ArtworkInfo

    var body: some View {
        switch tool {
        case .magnifyingGlass:
            MagnifyingOverlay(finding: finding, artwork: artwork)
        case .uvLight:
            UVOverlay(finding: finding, artwork: artwork)
        case .xRay:
            XRayOverlay(finding: finding, artwork: artwork)
        case .infrared:
            InfraredOverlay(finding: finding, artwork: artwork)
        case .chemicalAnalysis:
            ChemicalOverlay(finding: finding, artwork: artwork)
        case .provenanceSearch, .canvasDating:
            DocumentOverlay(finding: finding)
        }
    }
}

private struct MagnifyingOverlay: View {
    let finding: ToolFinding
    let artwork: ArtworkInfo
    var body: some View {
        ZStack {
            ArtworkCanvas(artwork: artwork)
                .blur(radius: 1)
            // Magnifying circle
            Circle()
                .fill(artwork.accentColor.opacity(0.12))
                .frame(width: 200, height: 200)
                .overlay(Circle().stroke(Color.white.opacity(0.6), lineWidth: 2))
                .overlay(
                    VStack(spacing: 6) {
                        Text("🔍 MAGNIFIED").font(.system(size: 9, weight: .bold)).tracking(2).foregroundStyle(.white)
                        Text(finding.headline).font(.system(size: 11, weight: .semibold)).foregroundStyle(.white).multilineTextAlignment(.center).padding(.horizontal, 8)
                    }
                )
                .offset(x: 40, y: -20)
        }
    }
}

private struct UVOverlay: View {
    let finding: ToolFinding
    let artwork: ArtworkInfo
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.00, blue: 0.18)
            // Glow zones
            RadialGradient(
                colors: [Color(red: 0.6, green: 0.9, blue: 1.0).opacity(0.6), .clear],
                center: UnitPoint(x: 0.5, y: 0.4),
                startRadius: 20,
                endRadius: 160
            )
            // UV annotation
            VStack(spacing: 8) {
                Label("UV FLUORESCENCE ANALYSIS", systemImage: "flashlight.on.fill")
                    .font(.system(size: 10, weight: .bold)).tracking(2)
                    .foregroundStyle(Color(red: 0.7, green: 0.5, blue: 1.0))
                Text(finding.headline)
                    .font(.system(size: 14, weight: .semibold)).foregroundStyle(.white).multilineTextAlignment(.center)
                Text(finding.detail.prefix(200) + (finding.detail.count > 200 ? "..." : ""))
                    .font(.system(size: 11)).foregroundStyle(Color.white.opacity(0.7)).multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            .padding(24)
        }
    }
}

private struct XRayOverlay: View {
    let finding: ToolFinding
    let artwork: ArtworkInfo
    var body: some View {
        ZStack {
            // Invert-ish grayscale
            ArtworkCanvas(artwork: artwork)
                .colorMultiply(Color(red: 0.7, green: 0.7, blue: 0.7))
                .grayscale(1.0)
                .colorInvert()
                .opacity(0.85)
            Color.black.opacity(0.35)
            VStack(spacing: 8) {
                Label("X-RADIOGRAPHY", systemImage: "camera.filters")
                    .font(.system(size: 10, weight: .bold)).tracking(2)
                    .foregroundStyle(Color(red: 0.5, green: 0.9, blue: 0.7))
                Text(finding.headline)
                    .font(.system(size: 14, weight: .semibold)).foregroundStyle(.white).multilineTextAlignment(.center)
                Text(finding.detail.prefix(200) + (finding.detail.count > 200 ? "..." : ""))
                    .font(.system(size: 11)).foregroundStyle(Color.white.opacity(0.7)).multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            .padding(24)
        }
    }
}

private struct InfraredOverlay: View {
    let finding: ToolFinding
    let artwork: ArtworkInfo
    var body: some View {
        ZStack {
            ArtworkCanvas(artwork: artwork)
                .colorMultiply(Color(red: 0.4, green: 0.9, blue: 0.4))
                .grayscale(0.7)
                .opacity(0.8)
            Color(red: 0.0, green: 0.08, blue: 0.0).opacity(0.5)
            VStack(spacing: 8) {
                Label("INFRARED REFLECTOGRAPHY", systemImage: "thermometer.medium")
                    .font(.system(size: 10, weight: .bold)).tracking(2)
                    .foregroundStyle(Color(red: 0.4, green: 1.0, blue: 0.4))
                Text(finding.headline)
                    .font(.system(size: 14, weight: .semibold)).foregroundStyle(.white).multilineTextAlignment(.center)
                Text(finding.detail.prefix(200) + (finding.detail.count > 200 ? "..." : ""))
                    .font(.system(size: 11)).foregroundStyle(Color.white.opacity(0.7)).multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            .padding(24)
        }
    }
}

private struct ChemicalOverlay: View {
    let finding: ToolFinding
    let artwork: ArtworkInfo
    var body: some View {
        ZStack {
            ArtworkCanvas(artwork: artwork)
            Color(red: 0.0, green: 0.05, blue: 0.12).opacity(0.75)
            // Coloured region indicators
            Circle().fill(Color.red.opacity(0.3)).frame(width: 60, height: 60).offset(x: -80, y: -40)
            Circle().fill(Color.blue.opacity(0.3)).frame(width: 45, height: 45).offset(x: 60, y: 20)
            Circle().fill(Color.yellow.opacity(0.25)).frame(width: 35, height: 35).offset(x: -20, y: 60)
            VStack(spacing: 8) {
                Label("CHEMICAL ANALYSIS", systemImage: "flask.fill")
                    .font(.system(size: 10, weight: .bold)).tracking(2)
                    .foregroundStyle(Color(red: 1.0, green: 0.8, blue: 0.3))
                Text(finding.headline)
                    .font(.system(size: 14, weight: .semibold)).foregroundStyle(.white).multilineTextAlignment(.center)
                Text(finding.detail.prefix(200) + (finding.detail.count > 200 ? "..." : ""))
                    .font(.system(size: 11)).foregroundStyle(Color.white.opacity(0.7)).multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            .padding(24)
        }
    }
}

private struct DocumentOverlay: View {
    let finding: ToolFinding
    var body: some View {
        ZStack {
            Color(red: 0.08, green: 0.07, blue: 0.05)
            VStack(spacing: 16) {
                Label(finding.tool == .provenanceSearch ? "PROVENANCE SEARCH" : "CANVAS & SUPPORT DATING",
                      systemImage: finding.tool.icon)
                    .font(.system(size: 10, weight: .bold)).tracking(2)
                    .foregroundStyle(AppColors.gold)
                Divider().background(AppColors.gold.opacity(0.3))
                Text(finding.headline)
                    .font(.system(size: 14, weight: .semibold)).foregroundStyle(.white).multilineTextAlignment(.center)
                Text(finding.detail.prefix(250) + (finding.detail.count > 250 ? "..." : ""))
                    .font(.system(size: 12)).foregroundStyle(Color.white.opacity(0.75)).multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            .padding(32)
        }
    }
}

// MARK: - Thumbnail (for cards)

struct ArtworkThumbnail: View {
    let artwork: ArtworkInfo
    let style: ArtworkInfo.ArtStyle

    var body: some View {
        ArtworkCanvas(artwork: artwork)
    }
}

#Preview {
    ArtworkDisplayView(
        artwork: LevelData.all[0].artwork,
        activeOverlay: .uvLight,
        finding: LevelData.all[0].toolFindings[.uvLight]
    )
    .frame(width: 500, height: 400)
}
