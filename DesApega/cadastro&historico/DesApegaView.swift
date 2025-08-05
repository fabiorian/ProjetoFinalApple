//
//  DesApegaView.swift
//  DesApega
//
//  Created by found on 27/07/25.
//


import SwiftUI
import PhotosUI
import SwiftData

struct DesApegaView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var doacaoExistente: Donation?
    
    @State private var tipoIdentificacao: String
    @State private var nomeUsuario: String
    @State private var nome: String
    @State private var categoria: Category
    @State private var status: Status
    @State private var local: String
    @State private var detalhes: String
    
    @State private var imagemSelecionada: PhotosPickerItem?
    @State private var imagem: UIImage?
    
    @State private var mostrarErro: String?
    @State private var sucesso = false
    
    let opcoesIdentificacao = ["Anônimo", "Colocar Nome"]
    
    init(doacaoExistente: Donation? = nil) {
        self.doacaoExistente = doacaoExistente
        _nome = State(initialValue: doacaoExistente?.name ?? "")
        _categoria = State(initialValue: doacaoExistente?.category ?? .clothe)
        _status = State(initialValue: doacaoExistente?.status ?? .otimo)
        _local = State(initialValue: doacaoExistente?.local ?? "")
        _detalhes = State(initialValue: doacaoExistente?.detalhes ?? "")
        _tipoIdentificacao = State(initialValue:
            doacaoExistente == nil
            ? "Anônimo"
            : (doacaoExistente!.doador == "Anônimo" ? "Anônimo" : "Colocar Nome")
        )
        _nomeUsuario = State(initialValue: doacaoExistente?.doador == "Anônimo" ? "" : (doacaoExistente?.doador ?? ""))
        if let data = doacaoExistente?.imageData {
            _imagem = State(initialValue: UIImage(data: data))
        } else {
            _imagem = State(initialValue: nil)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Identificação").font(.headline)
                Picker("Identificação", selection: $tipoIdentificacao) {
                    ForEach(opcoesIdentificacao, id: \.self) { Text($0) }
                }
                .pickerStyle(.segmented)
                
                if tipoIdentificacao == "Colocar Nome" {
                    TextField("Digite seu nome", text: $nomeUsuario)
                        .textFieldStyle(.roundedBorder)
                }
                
                Text("Nova Doação").font(.title2).bold()
                
                TextField("Nome da doação", text: $nome)
                    .textFieldStyle(.roundedBorder)
                
                Text("Categoria").font(.headline)
                Picker("Categoria", selection: $categoria) {
                    ForEach(Category.allCases, id: \.self) { cat in
                        Text(cat.rawValue)
                    }
                }
                .pickerStyle(.menu)
                
                Text("Estado de conservação").font(.headline)
                Picker("Estado", selection: $status) {
                    ForEach(Status.allCases, id: \.self) { estado in
                        Text(estado.rawValue)
                    }
                }
                .pickerStyle(.menu)
                
                TextField("Local (bairro, cidade...)", text: $local)
                    .textFieldStyle(.roundedBorder)
                
                Text("Descrição").font(.headline)
                TextEditor(text: $detalhes)
                    .frame(height: 120)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                
                PhotosPicker(selection: $imagemSelecionada, matching: .images) {
                    Text("Selecionar Imagem")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                
                if let uiImage = imagem {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                }
                
                if let erro = mostrarErro {
                    Text(erro)
                        .foregroundColor(.red)
                        .bold()
                }
                
                Button(doacaoExistente == nil ? "Anunciar Doação" : "Salvar Alterações") {
                    salvarDoacao()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                if sucesso {
                    Text(doacaoExistente == nil ? "Doação salva com sucesso!" : "Alterações salvas com sucesso!")
                        .foregroundColor(.green)
                        .bold()
                }
            }
            .padding()
//            .onChange(of: imagemSelecionada) { item in
//                Task {
//                    if let data = try? await item?.loadTransferable(type: Data.self),
//                       let uiImage = UIImage(data: data) {
//                        self.imagem = uiImage
//                    }
//                }
//            }
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName: "chevron.backward")
                    }
                }
            }
        }
        .accentColor(Color.saffron)
        .preferredColorScheme(.dark)


        .navigationTitle(doacaoExistente == nil ? "Nova Doação" : "Editar Doação")
        .navigationBarBackButtonHidden(true)
    }
    
    func salvarDoacao() {
        mostrarErro = nil
        sucesso = false
        
        if tipoIdentificacao == "Colocar Nome" && nomeUsuario.trimmingCharacters(in: .whitespaces).isEmpty {
            mostrarErro = "Digite seu nome."
            return
        }
        
        if nome.trimmingCharacters(in: .whitespaces).isEmpty ||
            local.trimmingCharacters(in: .whitespaces).isEmpty ||
            detalhes.trimmingCharacters(in: .whitespaces).isEmpty {
            mostrarErro = "Preencha todos os campos obrigatórios."
            return
        }
        
        let doadorFinal = tipoIdentificacao == "Anônimo" ? "Anônimo" : nomeUsuario
        let imagemData = imagem?.jpegData(compressionQuality: 0.8)
        
        if let doacaoExistente {
            doacaoExistente.name = nome
            doacaoExistente.status = status
            doacaoExistente.category = categoria
            doacaoExistente.detalhes = detalhes
            doacaoExistente.local = local
            doacaoExistente.doador = doadorFinal
            doacaoExistente.imageData = imagemData
            do {
                try context.save()
                sucesso = true
            } catch {
                mostrarErro = "Erro ao salvar: \(error.localizedDescription)"
            }
        } else {
            let nova = Donation(
                name: nome,
                status: status,
                category: categoria,
                detalhes: detalhes,
                doador: doadorFinal,
                local: local,
                imageData: imagemData
            )
            context.insert(nova)
            do {
                try context.save()
                sucesso = true
                limparCampos()
            } catch {
                mostrarErro = "Erro ao salvar: \(error.localizedDescription)"
            }
        }
    }
    
    func limparCampos() {
        nome = ""
        local = ""
        detalhes = ""
        imagem = nil
        nomeUsuario = ""
        tipoIdentificacao = "Anônimo"
        categoria = .clothe
        status = .otimo
    }
}

#Preview {
    DesApegaView()
}

