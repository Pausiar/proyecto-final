# 🗄️ BASE DE DATOS - BOOKING CREATOR

---

### 1️⃣ **USUARIOS** (Clientes)
```
- id_usuario (clave)
- nombre
- email (único)
- telefono
- password
- fecha_registro
```
**Función**: Gestión de clientes que hacen reservas

---

### 2️⃣ **CATEGORIAS**
```
- id_categoria (clave)
- nombre (Restaurantes, Belleza, etc.)
- icono (emoji)
```
**Función**: Clasificación de tipos de negocios
**Datos iniciales**: 6 categorías predefinidas

---

### 3️⃣ **EMPRESAS** (Negocios)
```
- id_empresa (clave)
- id_categoria
- nombre
- descripcion
- email, telefono
- direccion, ciudad
- logo_url
- imagen1_url, imagen2_url, imagen3_url (máx 3 fotos)
- verificado (sí/no)
- plan (gratuito/premium)
- puntuacion_promedio (calculado automático)
- total_resenas (calculado automático)
- fecha_registro
```
**Función**: Información de negocios que ofrecen servicios
**Nota**: Las imágenes están en la misma tabla (simplificado vs galería separada)

---

### 4️⃣ **RESERVAS**
```
- id_reserva (clave)
- codigo_reserva (ej: BK-2025-1234)
- id_usuario
- id_empresa
- fecha_reserva
- hora_reserva
- numero_personas
- nombre_cliente, email_cliente, telefono_cliente
- comentarios
- estado (confirmada/completada/cancelada)
- fecha_creacion
```
**Función**: Reservas realizadas por los usuarios
**Estados simples**: Solo 3 estados básicos

---

### 5️⃣ **PAGOS**
```
- id_pago (clave)
- id_reserva
- monto
- metodo_pago (tarjeta/paypal/efectivo)
- estado (pendiente/completado/fallido)
- fecha_pago
```
**Función**: Control básico de pagos
**Simplificado**: Sin integración compleja de pasarelas (para el proyecto)

---

### 6️⃣ **RESENAS** (Valoraciones)
```
- id_resena (clave)
- id_usuario
- id_empresa
- id_reserva (opcional)
- puntuacion (1-5 estrellas)
- comentario
- fecha_creacion
```
**Función**: Sistema de valoraciones y comentarios
**Automático**: Actualiza puntuación de empresa por trigger

---

### 7️⃣ **FAVORITOS**
```
- id_favorito (clave)
- id_usuario
- id_empresa
- fecha_agregado
```
**Función**: Empresas guardadas por cada usuario
**Simple**: Relación many-to-many básica

---

## 🔗 RELACIONES ENTRE TABLAS

```
USUARIOS ────┬──→ RESERVAS ──→ PAGOS
             │       │
             ├──→ RESENAS
             │
             └──→ FAVORITOS ←── EMPRESAS
                                   │
                              CATEGORIAS
```

---

## 🎯 FUNCIONALIDADES CUBIERTAS

### ✅ **Implementadas en esta versión:**
- Registro y login de usuarios
- Búsqueda de empresas por categoría y ciudad
- Sistema de reservas completo
- Pagos básicos (3 métodos)
- Reseñas con puntuación 1-5
- Ranking automático de empresas
- Favoritos de usuario
- Planes gratuito/premium
- Verificación básica de empresas


## 🔧 TRIGGER AUTOMÁTICO

**Actualización de puntuación de empresa:**
```sql
AFTER INSERT ON resenas
→ Recalcula puntuacion_promedio
→ Recalcula total_resenas
```
Esto te ahorra código en el backend y demuestra conocimiento de SQL avanzado.

---

## 📊 DATOS DE EJEMPLO

### Categorías iniciales:
1. 🍕 Restaurantes
2. 💇 Belleza
3. 🏥 Salud
4. 🏋️ Deportes
5. 🏨 Hospedaje
6. ⚙️ Otros

---
