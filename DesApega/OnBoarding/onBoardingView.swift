//
//  onBoardingView.swift
//  DesApega
//
//  Created by User on 04/08/25.
//

import SwiftUI





struct onBoardingView: View {

    @State private var showOnBoarding: Bool = true

    @State private var currentPage = 0

    @State private var navigateOnboarding = false



    var body: some View {

            VStack {

                Spacer()



                Image(onboardingPages[currentPage].image)

                    .resizable()

                    .scaledToFit()

                    .frame(height: 300)

                    .padding()



                Text(onboardingPages[currentPage].title)

                    .font(.largeTitle)

                    .bold()



                Text(onboardingPages[currentPage].description)

                    .font(.headline)

                    .multilineTextAlignment(.center)

                    .padding()



//                Spacer()



                HStack {

                    if currentPage > 0 {

                        Button("Voltar") {

                            withAnimation {

                                currentPage -= 1

                            }

                        }

                        .padding()

                    }



                    Spacer()



                    Button(currentPage == onboardingPages.count - 1 ? "Começar" : "Próximo") {

                        withAnimation {

                            if currentPage < onboardingPages.count - 1 {

                                currentPage += 1

                            } else {

                                currentPage = 0

                            }

                        }

                    }

                    .padding()

                }

                .padding(.horizontal)

                Spacer()

            }

            .transition(.slide)

        }

    }



#Preview {

    onBoardingView()

}
