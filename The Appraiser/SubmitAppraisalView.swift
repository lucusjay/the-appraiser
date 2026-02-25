// SubmitAppraisalView.swift
// The Appraiser — Submit Your Appraisal

import SwiftUI

struct SubmitAppraisalView: View {
    @Environment(GameManager.self) var game
    @Environment(\.dismiss) private var dismiss
    let artCase: AppraisalCase
    let onSubmit: () -> Void

    @State private var selectedChoice: Int? = nil
    @State private var showConfirm = false

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Button("Back") { dismiss() }
                        .foregroundStyle(AppColors.textMuted)
                    Spacer()
                    Text("SUBMIT APPRAISAL")
                        .font(.system(size: 13, weight: .semibold)).tracking(3)
                        .foregroundStyle(AppColors.gold)
                    Spacer()
                    Button("Back") { dismiss() }.opacity(0)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(AppColors.surface)

                ScrollView {
                    VStack(alignment: .leading, spacing: 28) {
                        // Goal reminder
                        VStack(alignment: .leading, spacing: 8) {
                            Label("YOUR ASSIGNMENT", systemImage: "target")
                                .font(.system(size: 10, weight: .bold)).tracking(2)
                                .foregroundStyle(AppColors.gold)
                            Text(artCase.goal.instruction)
                                .font(.system(size: 15))
                                .foregroundStyle(AppColors.textPrimary)
                                .lineSpacing(4)
                        }
                        .padding(20)
                        .background(AppColors.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 14))

                        // Findings summary
                        if !game.roundState.collectedFindings.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Label("YOUR FINDINGS", systemImage: "list.bullet.clipboard")
                                    .font(.system(size: 10, weight: .bold)).tracking(2)
                                    .foregroundStyle(AppColors.gold)
                                ForEach(game.roundState.collectedFindings) { finding in
                                    HStack(alignment: .top, spacing: 10) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(AppColors.success)
                                            .font(.system(size: 14))
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(finding.headline)
                                                .font(.system(size: 13, weight: .semibold))
                                                .foregroundStyle(AppColors.textPrimary)
                                            Text(finding.tool.rawValue)
                                                .font(.system(size: 11))
                                                .foregroundStyle(AppColors.textMuted)
                                        }
                                    }
                                }
                            }
                            .padding(20)
                            .background(AppColors.surface)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }

                        // Answer choices
                        VStack(alignment: .leading, spacing: 12) {
                            Label("YOUR ASSESSMENT", systemImage: "checkmark.seal")
                                .font(.system(size: 10, weight: .bold)).tracking(2)
                                .foregroundStyle(AppColors.gold)

                            Text("Based on your examination, what is your conclusion?")
                                .font(.system(size: 14))
                                .foregroundStyle(AppColors.textSecondary)

                            ForEach(Array(artCase.choices.enumerated()), id: \.offset) { index, choice in
                                ChoiceRow(
                                    text: choice,
                                    index: index,
                                    isSelected: selectedChoice == index
                                ) {
                                    selectedChoice = index
                                    game.selectChoice(index)
                                }
                            }
                        }
                        .padding(20)
                        .background(AppColors.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 14))

                        // Cost summary
                        VStack(alignment: .leading, spacing: 10) {
                            Label("COST SUMMARY", systemImage: "dollarsign.circle")
                                .font(.system(size: 10, weight: .bold)).tracking(2)
                                .foregroundStyle(AppColors.gold)

                            let toolCost = game.roundState.spentAmount
                            let expertCost = game.roundState.expertConsulted ? artCase.expert.cost : 0
                            let totalCost = toolCost + expertCost

                            CostRow(label: "Starting budget", value: "$\(artCase.startingBudget.formatted())", color: AppColors.textSecondary)
                            CostRow(label: "Tools & analysis", value: "-$\(toolCost.formatted())", color: toolCost > 0 ? AppColors.failure : AppColors.textMuted)
                            if expertCost > 0 {
                                CostRow(label: "Expert consultation", value: "-$\(expertCost.formatted())", color: AppColors.failure)
                            }
                            Divider().background(AppColors.gold.opacity(0.3))
                            CostRow(label: "Investigation costs", value: "$\(totalCost.formatted())", color: AppColors.textPrimary)

                            Divider().background(AppColors.gold.opacity(0.3))

                            CostRow(label: "If correct: client fee", value: "+$\(artCase.successPayout.formatted())", color: AppColors.success)
                            CostRow(label: "Net if correct", value: "$\((artCase.successPayout - totalCost).formatted())", color: AppColors.success)

                            CostRow(label: "If wrong: penalty", value: "-$\(artCase.failurePenalty.formatted())", color: AppColors.failure)
                        }
                        .padding(20)
                        .background(AppColors.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 14))

                        Spacer().frame(height: 100)
                    }
                    .padding(24)
                }

                // Submit button
                VStack(spacing: 12) {
                    Button {
                        if selectedChoice != nil {
                            showConfirm = true
                        }
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark.seal.fill")
                            Text("SUBMIT APPRAISAL")
                                .tracking(2)
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(selectedChoice != nil ? AppColors.background : AppColors.textMuted)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(selectedChoice != nil ? AppColors.gold : AppColors.surfaceElevated)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .buttonStyle(.plain)
                    .disabled(selectedChoice == nil)

                    if selectedChoice == nil {
                        Text("Select your assessment above before submitting.")
                            .font(.system(size: 12))
                            .foregroundStyle(AppColors.textMuted)
                    }
                }
                .padding(24)
                .background(AppColors.background)
                .overlay(alignment: .top) {
                    Rectangle().fill(AppColors.gold.opacity(0.15)).frame(height: 1)
                }
            }
        }
        .alert("Submit Your Appraisal?", isPresented: $showConfirm) {
            Button("Cancel", role: .cancel) {}
            Button("Submit", role: .destructive) {
                dismiss()
                onSubmit()
                game.submitAnswer()
            }
        } message: {
            if let idx = selectedChoice {
                Text("Your assessment: \"\(artCase.choices[idx])\"\n\nThis decision is final. Are you confident?")
            }
        }
    }
}

// MARK: - Supporting Views

private struct ChoiceRow: View {
    let text: String
    let index: Int
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .stroke(isSelected ? AppColors.gold : AppColors.textMuted.opacity(0.5), lineWidth: 2)
                        .frame(width: 22, height: 22)
                    if isSelected {
                        Circle()
                            .fill(AppColors.gold)
                            .frame(width: 12, height: 12)
                    }
                }
                Text(text)
                    .font(.system(size: 14, weight: isSelected ? .semibold : .regular))
                    .foregroundStyle(isSelected ? AppColors.textPrimary : AppColors.textSecondary)
                Spacer()
            }
            .padding(16)
            .background(isSelected ? AppColors.gold.opacity(0.1) : AppColors.surfaceElevated)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? AppColors.gold.opacity(0.5) : Color.clear, lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
    }
}

private struct CostRow: View {
    let label: String
    let value: String
    let color: Color
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(AppColors.textSecondary)
            Spacer()
            Text(value)
                .font(.system(size: 13, weight: .semibold, design: .monospaced))
                .foregroundStyle(color)
        }
    }
}

#Preview {
    SubmitAppraisalView(artCase: LevelData.all[0], onSubmit: {}).environment(GameManager())
}
