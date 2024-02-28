//
//  StarView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 27/02/24.
//

import UIKit

class StarMaskView: UIView {
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .orange
        progressView.trackTintColor = UIColor(white: 0, alpha: 0)
        return progressView
    }()
    
    init() {
        super.init(frame: .zero)
        setupMask()
        setupProgressView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupProgressView() {
        addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.topAnchor.constraint(equalTo: topAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setProgress(num: Float){
        self.progressView.progress = (num * 10) / 100
    }
    
    private func setupMask() {
        // Tamaño de cada estrella
        let starWidth = self.progressView.bounds.width / 10
        let starHeight = self.progressView.bounds.height * 4.5
        // Crear la capa de máscara
        let maskLayer = CAShapeLayer()
        // Posicionar cada estrella en fila
        for i in 0..<10 {
            let xOffset = CGFloat(i) * starWidth
            // Crear la forma de cada estrella
            let starPath = UIBezierPath()
            starPath.move(to: CGPoint(x: xOffset + 0.5 * starWidth, y: 0))
            starPath.addLine(to: CGPoint(x: xOffset + 0.65 * starWidth, y: 0.35 * starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + starWidth, y: 0.4 * starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.75 * starWidth, y: 0.65 * starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.8 * starWidth, y: starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.5 * starWidth, y: 0.85 * starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.2 * starWidth, y: starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.25 * starWidth, y: 0.65 * starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0, y: 0.4 * starHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.35 * starWidth, y: 0.35 * starHeight))
            starPath.close()
            // Crear una capa de forma y asignar la forma de la estrella
            let starMaskLayer = CAShapeLayer()
            starMaskLayer.path = starPath.cgPath
            starMaskLayer.fillColor = UIColor.orange.cgColor // Color del fondo
            maskLayer.addSublayer(starMaskLayer)
            // Crear una capa de borde
            let borderLayer = CAShapeLayer()
            borderLayer.path = starPath.cgPath
            borderLayer.fillColor = nil // No rellenar
            borderLayer.strokeColor = UIColor.orange.cgColor // Color del borde
            borderLayer.lineWidth = 2.0 // Grosor del borde
            borderLayer.frame = bounds
            layer.insertSublayer(borderLayer, at: 0) // Insertar detrás de la capa de fondo
        }
        // Asignar la capa de máscara a la vista
        layer.mask = maskLayer
    }
}
