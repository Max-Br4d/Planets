//
//  PlanetsListView.swift
//  Planets
//
//  Created by Max B. 17/04/2023.
//

import SwiftUI

struct PlanetsListView: View {
    @StateObject var viewModel: PlanetsViewModel
    @State private var isErrorOccured = true
    
    var body: some View {
        NavigationStack{
            VStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                case .loaded:
                    showSchoolListView()
                case .error:
                    showErrorView()
                case .emptyView:
                    EmptyView()
                }
            }
            .navigationTitle(Text(LocalizedStringKey("Planets")))
        }.task {
            await viewModel.getPlanets()
        }
    }
    @ViewBuilder
    func showSchoolListView() -> some View {
        List(viewModel.planets){ planet in
            NavigationLink {
                PlanetDetailsView(planet: planet)
            }label: {
                PlanetCellView(planet: planet)
            }
        }
    }
    @ViewBuilder
    func showErrorView() -> some View {
        ProgressView().alert(isPresented: $isErrorOccured){
            Alert(title: Text("Error Occured"),message: Text("Something went wrong"),
                  dismissButton: .default(Text("Ok")))
        }
    }
}

struct PlanetsListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetsListView(viewModel: PlanetsViewModel(repository: PlanetsRepository(serviceManager: RestApiManager())))
    }
}
