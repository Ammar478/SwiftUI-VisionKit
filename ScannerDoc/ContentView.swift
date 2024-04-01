//
//  ContentView.swift
//  ScannerDoc
//
//  Created by Ammar Ahmed on 21/09/1445 AH.
//

import SwiftUI

struct ScannerDocDTO:Identifiable{
    var id = UUID()
    var docmentText:String
}

struct ContentView: View {
    
    @State private var isScanDoc = false
    @State private var listScanDoc:[ScannerDocDTO] = []
    
    private func makeScanView()->ScannerView{
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines){
                let newScanData = ScannerDocDTO(docmentText: outputText)
                self.listScanDoc.append(newScanData)
            }
            self.isScanDoc = false
        })
    }
    var body: some View {
        NavigationStack{
            
            List{
                Section("Docmentes"){
                    VStack{
                                  if listScanDoc.count > 0{
                                      List{
                                          ForEach(listScanDoc){text in
                                              NavigationLink(
                                                destination:ScrollView{Text(text.docmentText)},
                                                  label: {
                                                      Text(text.docmentText).lineLimit(1)
                                                  })
                                          }
                                      }
                                  }
                                  else{
                                      Text("No scan yet").font(.title)
                                  }
                              }
                }
            }
            .toolbar{
                ToolbarItem(placement:.topBarTrailing){
                    Button{
                        isScanDoc.toggle()
                    }label: {
                        Image(systemName: "doc.viewfinder")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $isScanDoc){
                makeScanView()
            }
        }
    }
}

#Preview {
    ContentView()
}
