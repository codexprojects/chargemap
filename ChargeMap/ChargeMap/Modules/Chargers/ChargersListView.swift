//
//  ChargersListView.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import SwiftUI

struct ChargersListView: View {
    @ObservedObject var viewModel: ChargersMapDataViewModel
    let siteID: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                        .padding(.all, 10)
                }
            }
            LegendView()
            List {
                ForEach(viewModel.chargers.filter { $0.siteID == siteID }, id: \.id) { charger in
                    ChargerSectionView(charger: charger)
                }
            }
            .task {
                await viewModel.fetchChargers()
            }
            .alert(item: $viewModel.fetchError) { fetchError in
                Alert(title: Text("Error"), message: Text(fetchError.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct LegendView: View {
    var body: some View {
        HStack {
            LegendItemView(color: .green, text: "Available")
            LegendItemView(color: .blue, text: "Charging")
            LegendItemView(color: .red, text: "Faulty")
        }
        .padding()
    }
}

struct LegendItemView: View {
    let color: Color
    let text: String
    
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 10, height: 10)
            Text(text)
        }
    }
}

struct ChargerSectionView: View {
    let charger: Charger
    
    var body: some View {
        Section(header: Text(charger.name)) {
            ForEach(charger.evses, id: \.id) { evse in
                EVSEView(evse: evse, connectors: charger.connectors.filter { $0.evseId == evse.id })
            }
        }
    }
}

struct EVSEView: View {
    let evse: EVSE
    let connectors: [Connector]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("EVSE: \(evse.code)")
            ForEach(connectors, id: \.id) { connector in
                ConnectorView(connector: connector)
            }
        }
    }
}

struct ConnectorView: View {
    let connector: Connector
    
    var body: some View {
        HStack {
            Text("Connector ID: \(connector.id), Power: \(connector.power)")
            Spacer()
            Circle()
                .foregroundColor(connector.statusColor)
                .frame(width: 10, height: 10)
        }
    }
}

extension Connector {
    var statusColor: Color {
        switch status {
        case 0: return .green
        case 1: return .blue
        case 2: return .red
        default: return .gray
        }
    }
}
