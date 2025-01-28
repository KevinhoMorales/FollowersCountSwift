//
//  ProPlansView.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 28/1/25.
//

import SwiftUI

// Código global para desbloquear la aplicación
let unlockCode = "DEVLOKOS2025" // Código válido

// Vista de planes PRO
struct ProPlansView: View {
    @State private var selectedPlan: String? = nil // Estado para el plan seleccionado
    @State private var showAlert = false // Estado para mostrar la alerta
    @State private var inputCode = "" // Estado para almacenar el código ingresado
    @State private var isUnlocked = false // Estado para rastrear si la aplicación está desbloqueada
    @State private var showThankYouMessage = false // Estado para mostrar el mensaje de agradecimiento

    var body: some View {
        VStack(spacing: 20) {
            Text("Planes PRO")
                .font(.largeTitle)
                .foregroundColor(.frontColor) // Asegurar que el texto sea visible
                .padding(.top, 20)

            // Plan Trimestral
            PlanCard(
                title: "Trimestral",
                price: "$9.99",
                description: "Acceso a todas las funciones PRO por 3 meses.",
                isSelected: selectedPlan == "Trimestral"
            )
            .onTapGesture {
                selectedPlan = "Trimestral"
                print("Plan seleccionado: Trimestral")
            }

            // Plan Anual
            PlanCard(
                title: "Anual",
                price: "$29.99",
                description: "Acceso a todas las funciones PRO por 1 año.",
                isSelected: selectedPlan == "Anual"
            )
            .onTapGesture {
                selectedPlan = "Anual"
                print("Plan seleccionado: Anual")
            }

            // Plan Vitalicio
            PlanCard(
                title: "Vitalicio",
                price: "$99.99",
                description: "Acceso permanente a todas las funciones PRO.",
                isSelected: selectedPlan == "Vitalicio"
            )
            .onTapGesture {
                selectedPlan = "Vitalicio"
                print("Plan seleccionado: Vitalicio")
            }

            Spacer()

            // Mensaje de agradecimiento si la aplicación está desbloqueada
            if showThankYouMessage {
                VStack() {
                    Text("¡Gracias por ser parte de la comunidad DevLokos!")
                        .font(.headline)
                        .foregroundColor(.backColor)
                        .padding(.bottom, 10)
                        .multilineTextAlignment(.center)
                    
                    Text("Por ello, puedes acceder a la aplicación de forma gratuita.")
                        .font(.subheadline)
                        .foregroundColor(.grayColor)
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 20)
            }

            // Sección para la comunidad DevLokos
            VStack {
                Text("¿Eres de la comunidad DevLokos?")
                    .font(.subheadline)
                    .foregroundColor(.grayColor)
                
                Button(action: {
                    showAlert = true // Mostrar la alerta para ingresar el código
                }) {
                    Text("Desbloquear aplicación")
                        .font(.headline)
                        .foregroundColor(.frontColor)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.backColor)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
        .background(Color.frontColor) // Fondo de la vista
        .alert("Ingresa el código de desbloqueo", isPresented: $showAlert) {
            TextField("Código", text: $inputCode) // Campo de texto para ingresar el código
            Button("Aceptar") {
                if inputCode == unlockCode { // Validar el código
                    isUnlocked = true
                    showThankYouMessage = true
                    print("Aplicación desbloqueada")
                } else {
                    print("Código incorrecto")
                }
            }
            Button("Cancelar", role: .cancel) {
                inputCode = "" // Limpiar el campo de texto
            }
        }
    }
}

// Componente de tarjeta de plan
struct PlanCard: View {
    var title: String
    var price: String
    var description: String
    var isSelected: Bool = false

    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(isSelected ? .frontColor : .backColor)
            
            Text(price)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(isSelected ? .frontColor : .backColor)
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(isSelected ? .frontColor.opacity(0.9) : .grayColor)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color.backColor : Color.grayColor.opacity(0.2))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.backColor : Color.grayColor, lineWidth: 1)
        )
    }
}

#Preview {
    ProPlansView()
}
