//
//  HistoricView.swift
//  DesApega
//
//  Created by found on 27/07/25.
//


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
                List(donations, id: \.id) { donation in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(donation.name).font(.headline)
                        Text("Categoria: \(donation.category.rawValue)")
                        Text("Status: \(donation.status.rawValue)")
                        Text("Doador: \(donation.doador)")
                        Text("Local: \(donation.local)")
                        Text("Data: \(donation.time, formatter: dateFormatter)")
                            .font(.caption)
                            .foregroundColor(.gray)

                        if let data = donation.imageData,
                           let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .cornerRadius(8)
                                .onTapGesture {
                                    imagemParaExibir = image
                                    mostrarImagem = true
                                }
                        }
                    }
                    .padding(.vertical, 8)
                    .contentShape(Rectangle()) // para tornar tudo clicável
                    .onTapGesture {
                        if doacaoSelecionada?.id == donation.id {
                            doacaoSelecionada = nil // desmarcar se tocar de novo
                        } else {
                            doacaoSelecionada = donation
                        }
                    }
                    .background(doacaoSelecionada?.id == donation.id ? Color.blue.opacity(0.1) : Color.clear)
                    .animation(.easeInOut, value: doacaoSelecionada?.id)
                }

                // Rodapé com os botões Editar e Excluir
                if doacaoSelecionada != nil {
                    VStack {
                        Divider()
                        HStack {
                            Button("Editar") {
                                mostrarEdicao = true
                            }
                            .foregroundColor(.blue)
                            .padding()
                            .frame(maxWidth: .infinity)

                            Button("Excluir") {
                                mostrarAlertaExcluir = true
                            }
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                        }
                        .background(Color(.systemGroupedBackground))
                    }
                }
            }
            .navigationTitle("Histórico de Doações")
        }

        // Sheet de edição
        .sheet(isPresented: $mostrarEdicao) {
            if let doacao = doacaoSelecionada {
                NavigationStack {
                    DesApegaView(doacaoExistente: doacao)
                }
            }
        }

        // Sheet da imagem
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

        // Alerta de exclusão
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
