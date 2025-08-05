import SwiftUI
import SwiftData

struct HistoricView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Donation.time, order: .reverse) private var donations: [Donation]

    @State private var doacaoSelecionada: Donation?
    @State private var mostrarEdicao = false
    @State private var imagemParaExibir: UIImage?
    @State private var mostrarImagem = false
    @State private var mostrarAlertaExcluir = false

    var body: some View {
        NavigationStack {
            VStack {
                if donations.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "tray")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)

                        Text("Nenhuma doação encontrada")
                            .foregroundColor(.gray)
                            .font(.title3)
                    }
                    .padding()
                } else {
                    List(donations, id: \.id) { donation in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(donation.name)
                                        .font(.headline)
                                        .foregroundColor(.white)

                                    Text("Categoria: \(donation.category.rawValue)")
                                        .foregroundColor(.yellow)

                                    Text("Status: \(donation.status.rawValue)")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)

                                    Text("Doador: \(donation.doador)")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)

                                    Text("Local: \(donation.local)")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)

                                    Text("Data: \(donation.time, formatter: dateFormatter)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                if let data = donation.imageData,
                                   let image = UIImage(data: data) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipped()
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            imagemParaExibir = image
                                            mostrarImagem = true
                                        }
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            doacaoSelecionada = doacaoSelecionada?.id == donation.id ? nil : donation
                        }
                        .listRowBackground(doacaoSelecionada?.id == donation.id ? Color.yellow.opacity(0.15) : Color.clear)
                    }
                    .listStyle(.plain)
                }

                if doacaoSelecionada != nil {
                    VStack(spacing: 0) {
                        Divider()
                            .background(.yellow)
                        HStack {
                            Button(action: { mostrarEdicao = true }) {
                                Label("Editar", systemImage: "pencil")
                                    .foregroundColor(.yellow)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.black.opacity(0.2))
                                    .cornerRadius(10)
                            }

                            Button(action: { mostrarAlertaExcluir = true }) {
                                Label("Excluir", systemImage: "trash")
                                    .foregroundColor(.red)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.black.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 6)
                    }
                }
            }
            .padding(.top)
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Histórico")
            .foregroundColor(.white)
        }
        .sheet(isPresented: $mostrarEdicao) {
            if let doacao = doacaoSelecionada {
                NavigationStack {
                    DesApegaView(doacaoExistente: doacao)
                }
            }
        }
        .sheet(isPresented: $mostrarImagem) {
            if let imagem = imagemParaExibir {
                ZStack {
                    Color.black.ignoresSafeArea()
                    Image(uiImage: imagem)
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            mostrarImagem = false
                        }
                }
            }
        }
        .alert("Confirmar Exclusão", isPresented: $mostrarAlertaExcluir) {
            Button("Cancelar", role: .cancel) {}
            Button("Excluir", role: .destructive) {
                if let doacao = doacaoSelecionada {
                    context.delete(doacao)
                    try? context.save()
                    doacaoSelecionada = nil
                }
            }
        } message: {
            Text("Deseja realmente excluir esta doação?")
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()
#Preview {
   HistoricView()
}
