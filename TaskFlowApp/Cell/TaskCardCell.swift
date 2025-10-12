//
//  TaskCardCell.swift
//  Modern-SwiftUI-Bootcamp
//
//  Created by İrem Sever on 12.10.2025.
//
import SwiftUI

struct TaskCardCell: View {
    let task: Task
    let color: Color
    var fixedHeight: CGFloat = 148
    var onToggle: () -> Void
    var onDelete: () -> Void

    @GestureState private var dragX: CGFloat = 0
    @State private var offsetX: CGFloat = 0
    private let trigger: CGFloat = 90

    private var deleteProgress: Double {
        let p = abs(offsetX + dragX) / trigger
        return Double(min(max(p, 0), 1))
    }

    var body: some View {
        ZStack {
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.red)
                Image(systemName: "trash.fill")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.trailing, 18)
                    .scaleEffect(0.8 + 0.5 * deleteProgress)
                    .opacity(0.5 + 0.5 * deleteProgress)
            }
            .frame(maxWidth: .infinity, minHeight: fixedHeight, maxHeight: fixedHeight)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "paperclip.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.white.opacity(0.9))
                    Spacer()
                    Button {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.85)) { onToggle() }
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    } label: {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .font(.system(size: 26, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(4)
                            .background(Circle().fill(.white.opacity(0.18)))
                    }
                    .buttonStyle(.plain)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(task.title)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .lineLimit(2)
                    Text(task.isCompleted ? "Completed" : "In progress")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.95))

                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(.white.opacity(0.25)).frame(height: 6)
                            Capsule().fill(.white)
                                .frame(width: geo.size.width * (task.isCompleted ? 1 : 0.4), height: 6)
                        }
                    }
                    .frame(height: 6)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, minHeight: fixedHeight, maxHeight: fixedHeight)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(color.gradient)
            )
            .offset(x: offsetX + dragX)
            .gesture(
                DragGesture(minimumDistance: 10)
                    .updating($dragX) { value, state, _ in
                        // sadece sola kaydırma
                        state = min(0, value.translation.width)
                    }
                    .onEnded { value in
                        let total = min(0, value.translation.width + offsetX)
                        if abs(total) > trigger {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.85)) {
                                offsetX = 0
                                onDelete()
                            }
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        } else {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
                                offsetX = 0
                            }
                        }
                    }
            )
        }
        .frame(height: fixedHeight)
    }
}
