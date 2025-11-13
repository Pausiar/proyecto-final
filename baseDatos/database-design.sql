-- ============================================
-- BOOKING CREATOR - BASE DE DATOS SIMPLIFICADA
-- ============================================

-- TABLA: USUARIOS
-- Clientes que hacen reservas
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email)
);

-- TABLA: CATEGORIAS
-- Tipos de negocios
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    icono VARCHAR(50)
);

-- TABLA: EMPRESAS
-- Negocios que ofrecen servicios
CREATE TABLE empresas (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    email VARCHAR(255) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(300) NOT NULL,
    ciudad VARCHAR(100),
    
    -- Multimedia básica
    logo_url VARCHAR(500),
    imagen1_url VARCHAR(500),
    imagen2_url VARCHAR(500),
    imagen3_url VARCHAR(500),
    
    -- Control básico
    verificado BOOLEAN DEFAULT FALSE,
    plan ENUM('gratuito', 'premium') DEFAULT 'gratuito',
    
    -- Estadísticas automáticas
    puntuacion_promedio DECIMAL(3, 2) DEFAULT 0.00,
    total_resenas INT DEFAULT 0,
    
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    INDEX idx_categoria (id_categoria),
    INDEX idx_ciudad (ciudad),
    INDEX idx_puntuacion (puntuacion_promedio)
);

-- TABLA: RESERVAS
-- Reservas de usuarios en empresas
CREATE TABLE reservas (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    codigo_reserva VARCHAR(20) UNIQUE NOT NULL,
    
    id_usuario INT NOT NULL,
    id_empresa INT NOT NULL,
    
    -- Información básica
    fecha_reserva DATE NOT NULL,
    hora_reserva TIME NOT NULL,
    numero_personas INT DEFAULT 1,
    
    nombre_cliente VARCHAR(100) NOT NULL,
    email_cliente VARCHAR(255) NOT NULL,
    telefono_cliente VARCHAR(20) NOT NULL,
    comentarios TEXT,
    
    -- Control de estado
    estado ENUM('confirmada', 'completada', 'cancelada') DEFAULT 'confirmada',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa),
    INDEX idx_usuario (id_usuario),
    INDEX idx_empresa (id_empresa),
    INDEX idx_fecha (fecha_reserva),
    INDEX idx_codigo (codigo_reserva)
);

-- TABLA: PAGOS
-- Pagos asociados a reservas
CREATE TABLE pagos (
    id_pago INT PRIMARY KEY AUTO_INCREMENT,
    id_reserva INT NOT NULL,
    
    monto DECIMAL(10, 2) NOT NULL,
    metodo_pago ENUM('tarjeta', 'paypal', 'efectivo') NOT NULL,
    estado ENUM('pendiente', 'completado', 'fallido') DEFAULT 'completado',
    
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva),
    INDEX idx_reserva (id_reserva)
);

-- TABLA: RESENAS
-- Valoraciones de usuarios
CREATE TABLE resenas (
    id_resena INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_empresa INT NOT NULL,
    id_reserva INT NULL,
    
    puntuacion INT NOT NULL CHECK (puntuacion BETWEEN 1 AND 5),
    comentario TEXT,
    
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa),
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva) ON DELETE SET NULL,
    INDEX idx_usuario (id_usuario),
    INDEX idx_empresa (id_empresa),
    INDEX idx_puntuacion (puntuacion)
);

-- TABLA: FAVORITOS
-- Empresas favoritas de usuarios
CREATE TABLE favoritos (
    id_favorito INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_empresa INT NOT NULL,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa) ON DELETE CASCADE,
    UNIQUE KEY unique_favorito (id_usuario, id_empresa)
);

-- ============================================
-- DATOS INICIALES
-- ============================================

INSERT INTO categorias (nombre, icono) VALUES
('Restaurantes', '🍕'),
('Belleza', '💇'),
('Salud', '🏥'),
('Deportes', '🏋️'),
('Hospedaje', '🏨'),
('Otros', '⚙️');

-- ============================================
-- TRIGGER: Actualizar puntuación automática
-- ============================================

DELIMITER //
CREATE TRIGGER actualizar_puntuacion_empresa
AFTER INSERT ON resenas
FOR EACH ROW
BEGIN
    UPDATE empresas
    SET 
        puntuacion_promedio = (
            SELECT AVG(puntuacion)
            FROM resenas
            WHERE id_empresa = NEW.id_empresa
        ),
        total_resenas = (
            SELECT COUNT(*)
            FROM resenas
            WHERE id_empresa = NEW.id_empresa
        )
    WHERE id_empresa = NEW.id_empresa;
END //
DELIMITER ;