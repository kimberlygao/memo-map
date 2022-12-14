//
//  RecentDetailView.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/17.
//

import Foundation
import SwiftUI

struct RecentDetailView<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isOpen: Bool

    let maxHeight: CGFloat
    @Binding var minHeight: CGFloat
    let content: Content

    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
      isOpen ? 0 : (maxHeight - self.minHeight) 
    }

    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.RADIUS)
            .fill(Color("pastel"))
            .frame(
                width: Constants.INDICATOR_WIDTH,
                height: Constants.INDICATOR_HEIGHT
        ).onTapGesture {
            self.isOpen.toggle()
        }
    }

  init(isOpen: Binding<Bool>, maxHeight: CGFloat, minHeight: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self._minHeight = minHeight // maxHeight * Constants.MIN_HEIGHT_RATIO
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding()
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color.white)
            .cornerRadius(Constants.RADIUS)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * Constants.SNAP_RATIO
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}
