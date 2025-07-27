import SwiftUI

struct DHsView: View {
    let DHs: DonationsHouse
    @State private var endereco: String = ""

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Ícone da categoria
            Image(systemName: "house")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(10)
                .background(Color.blue.opacity(0.1))
                .foregroundColor(.blue)
                .clipShape(Circle())

            // Conteúdo principal
            VStack(alignment: .leading, spacing: 3) {
                Text(DHs.name)
                    .font(.title3)
                    .fontWeight(.semibold)

                Label("Endereço: \(endereco)", systemImage: "mappin.and.ellipse")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Label("Tipo: \(DHs.category.rawValue)", systemImage: iconForCategory(DHs.category))
                    .font(.subheadline)
                    .foregroundColor(.blue)

//                Label("Descrição: \(DHs.description)", systemImage: "text.alignleft")
//                    .font(.subheadline)
//                    .foregroundStyle(.secondary)
            }

//            Spacer()
        }
        .padding()
//        .background(
//            RoundedRectangle(cornerRadius: 16)
//                .fill(Color(.systemBackground))
//                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
//        )
        
        .onAppear {
            DHs.reverseGeocoding { result in
                endereco = result ?? "Endereço não disponível"
            }
        }
    }

    // Função auxiliar para ícones personalizados por categoria
    func iconForCategory(_ category: Category) -> String {
        switch category {
        case .clothe: return "tshirt"
        case .footwear: return "shoeprints.fill"
        case .eletronic: return "cpu"
        case .toy: return "gamecontroller.fill"
        }
    }
}
#Preview {
    DHsView(DHs: DonationsHouse(name: "Casa de Doação", category: .clothe, description: "Aceitamos roupas para uso em nossa  comunidade", latitude: -3.895542, longitude: -38.70283, imageName: ""))
}
