//
//  HomeView.swift
//  WalletCardAnimation
//
//  Created by Daniel Martinez Condinanza on 5/12/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    
    var size: CGSize
    var safeArea: EdgeInsets
    
    
    @State private var showDetailView: Bool = false
    @State private var selectedCard: Card?
    @Namespace private var animation

    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                Text("My Wallet")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .trailing) {
                        Button {
                            
                        } label: {
                            Image(.pic)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 35, height: 35)
                                .clipShape(.circle)
                        }
                    }
                    .blur(radius: showDetailView ? 5 : 0)
                    .opacity(showDetailView ? 0 : 1)
                
                let mainOffset = CGFloat(cards.firstIndex(where: { $0.id == selectedCard?.id}) ?? 0 ) * -size.width
                
                // Cards View
                VStack(spacing: 10) {
                    ForEach(cards) { card in
                        
                        let cardOffset = CGFloat(cards.firstIndex(where: { $0.id == card.id}) ?? 0 ) * size.width
                        CardView(card)
                            .frame(width: showDetailView ? size.width : nil)
                            .visualEffect { [showDetailView] content, proxy in
                                content.offset(x: showDetailView ? cardOffset : 0, y: showDetailView ? -proxy.frame(in: .scrollView).minY : 0)
                            }
                    }
                }
                .padding(.top, 25)
                .offset(x: showDetailView ? mainOffset : 0)
            }
            .safeAreaPadding(showDetailView ? 0 : 15)
            .safeAreaPadding(.top, safeArea.top)
        }
        .scrollDisabled(showDetailView)
        .scrollIndicators(.hidden)
        .overlay {
            if let selectedCard, showDetailView {
                DetailView(selectedCard: selectedCard)
                    .padding(.top, expandedCardHeight)
                    .transition(.move(edge: .bottom))
            }
        }
        
    }
}

extension HomeView {
    
    @ViewBuilder
    func CardView(_ card: Card) -> some View {
        ZStack {
            Rectangle()
                .fill(card.color.gradient)
            
            // Card Details View
            
            VStack(alignment: .leading, spacing: 15) {
                if !showDetailView {
                    VisaImageView(card.visaGeomtryId, height: 20)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(card.number)
                        .font(.caption)
                        .foregroundStyle(.white.secondary)
                    
                    Text("$28,201.00")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: showDetailView ? .center : .leading)
                .overlay {
                    ZStack {
                        if showDetailView {
                            VisaImageView(card.visaGeomtryId, height: 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .offset(y: 45)
                        }
                        
                        if let selectedCard, selectedCard.id == card.id, showDetailView {
                            Button {
                                withAnimation(.smooth(duration: 0.5, extraBounce: 0)) {
                                    self.selectedCard = nil
                                    self.showDetailView = false
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                                    .contentShape(.rect)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .transition(.asymmetric(insertion: .opacity, removal: .identity))
                        }
                        
                    }
                }
                .padding(.top, showDetailView ? safeArea.top - 10 : 0)
                
                HStack {
                    Text("Expires: \(card.expires)")
                        .font(.caption)
                    
                    Spacer()
                    
                    Text("John Doe")
                        .font(.callout)
                }
                .foregroundStyle(.white.secondary)
                
            }
            .padding(showDetailView ? 15 : 25)
        }
        .frame(height: showDetailView ? expandedCardHeight : nil)
        .frame(height: 200, alignment: .top)
        .clipShape(.rect(cornerRadius: showDetailView ? 0 : 25))
        .onTapGesture {
            guard !showDetailView else { return }
            withAnimation(.smooth(duration: 0.5, extraBounce: 0)) {
                selectedCard = card
                showDetailView = true
            }
        }
    }
    
    @ViewBuilder
    func VisaImageView(_ id: String, height: CGFloat) -> some View {
        Image(.visa)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .matchedGeometryEffect(id: id, in: animation)
            .frame(height: height)
    }

    var expandedCardHeight: CGFloat {
        safeArea.top + 130
    }
}

struct DetailView: View {
    var selectedCard: Card
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 12) {
                ForEach(1...20, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black.gradient)
                        .frame(height: 45)
                }
            }
            .padding(15)
        }
    }
}


#Preview {
    ContentView()
}