db.devices.insertMany([
    { name: "Celular" },
    { name: "Laptop" },
    { name: "PC" },
    { name: "Cámara" },
    { name: "Tablet" },
    { name: "Smartwatch" },
    { name: "Televisor" },
    { name: "Consola de videojuegos" }
])

db.devices.find()

db.brands.insertMany([
    { name: "Samsung" },
    { name: "Huawei" },
    { name: "Apple" },
    { name: "Xiaomi" },
    { name: "Sony" },
    { name: "LG" },
    { name: "Motorola" },
    { name: "Lenovo" },
    { name: "HP" },
    { name: "Dell" },
    { name: "Asus" }
])
db.brands.find()


//----------------------
//technical_services
//----------------------
db.technical_services.insertMany([
    {
        name: "TechRepair",
        description: "Especialistas en reparación de dispositivos electrónicos. Servicio rápido y confiable.",
        repairs_available: {
             devices_id: [
                         ObjectId("648fa7a4bc52811108db3875"),
                         ObjectId("648fa7a4bc52811108db3876"),
                         ObjectId("648fa7a4bc52811108db3878")
            ],
             brands_id: [
                 ObjectId("648fa8e8bc52811108db3881"),
                 ObjectId("648fa8e8bc52811108db3882"),
                 ObjectId("648fa8e8bc52811108db3883")
            ]
        },
        hours_attention: [
           "Lunes - Viernes: 8:00 am - 7:00 pm",
           "Sábado - Domingo: 10:00 am - 3:00 pm"
       ]
    },
    {
        name: "SmartFix",
        description: "Reparación de dispositivos móviles y tablets. Calidad y rapidez garantizada.",
        repairs_available: {
            devices_id: [
                ObjectId("648fa7a4bc52811108db3875"),
                ObjectId("648fa7a4bc52811108db3879")
            ],
            brands_id: [
                ObjectId("648fa8e8bc52811108db3881"),
                ObjectId("648fa8e8bc52811108db3884")
            ]
        },
        hours_attention: [
            "Lunes - Viernes: 9:00 am - 6:00 pm"
        ]
    },
    {
        name: "PCMaster",
        description: "Reparación de computadoras y laptops. Soluciones eficientes para tus equipos.",
        repairs_available: {
            devices_id: [
                ObjectId("648fa7a4bc52811108db3876")
            ],
            brands_id: [
                ObjectId("648fa8e8bc52811108db3883"),
                ObjectId("648fa8e8bc52811108db3886")
            ]
        },
        hours_attention: [
            "Lunes - Viernes: 10:00 am - 8:00 pm"
        ],
        score: 4.8
    },
    {
        name: "GadgetFix",
        description: "Servicio técnico especializado en reparación de gadgets y dispositivos electrónicos.",
        repairs_available: {
            devices_id: [
                ObjectId("648fa7a4bc52811108db3875"), // Celular
                ObjectId("648fa7a4bc52811108db3879"), // Tablet
                ObjectId("648fa7a4bc52811108db387b")  // Televisor
            ],
            brands_id: [
                ObjectId("648fa8e8bc52811108db3881"), // Samsung
                ObjectId("648fa8e8bc52811108db3884")  // Xiaomi
            ]
        },
        hours_attention: [
            "Lunes - Viernes: 9:00 am - 6:00 pm",
            "Sábado: 10:00 am - 2:00 pm"
        ]
    },
    {
        name: "ElectroFix",
        description: "Reparación de electrodomésticos y equipos electrónicos. Servicio eficiente y económico.",
        repairs_available: {
            devices_id: [
                ObjectId("648fa7a4bc52811108db387b")
            ],
            brands_id: [
                ObjectId("648fa8e8bc52811108db3886")
            ]
        },
        hours_attention: [
            "Lunes - Viernes: 9:00 am - 5:00 pm"
        ],
        score: 4.2
    }
])

db.technical_services.find()


//----------------------
//Clients
//----------------------

db.clients.insertOne({
    name: "Zephyrus",
    first_lastname: "Von Helsing",
    first_lastname: "Fierbe",
    username: "zephyrus",
    email: "zephyrus@gmail.com",
    password: "P@ssw0rd!",
    technical_services_id: [
        ObjectId("648fad93bc52811108db388d")
    ]
})

db.clients.insertOne({
    name: "Lilith",
    first_lastname: "Ravenscroft",
    username: "lilith",
    email: "lilith@hotmail.com",
    password: "Secur3P@ss!"
})

db.clients.insertOne({
    name: "Cassius",
    first_lastname: "Nightshade",
    username: "cassius",
    email: "cassius@gmail.com",
    phone_number: "902145739",
    password: "MyP@55word"
})

db.clients.insertOne({
    name: "Aurelia",
    first_lastname: "Drakonov",
    username: "aurelia",
    email: "aurelia@hotmail.com",
    password: "C0mpl3xP@ss",
    technical_services_id: [
        ObjectId("648fad93bc52811108db388e"),
        ObjectId("648fad93bc52811108db388f")
    ]
})

db.clients.insertOne({
    name: "Xander",
    first_lastname: "Shadowthorn",
    username: "xander",
    email: "xander@gmail.com",
    password: "R0bustP@ss!"
})


//----------------------
//Models
//----------------------

db.models.insertMany([
  {
    name: "Galaxy S10+",
    brand_id: ObjectId("648fa8e8bc52811108db3881")
  },
  {
    name: "P30 Pro",
    brand_id: ObjectId("648fa8e8bc52811108db3882")
  },
  {
    name: "iPhone 12",
    brand_id: ObjectId("648fa8e8bc52811108db3883")
  },
  {
    name: "Mi 9T",
    brand_id: ObjectId("648fa8e8bc52811108db3884")
  },
  {
    name: "OLED TV",
    brand_id: ObjectId("648fa8e8bc52811108db3886")
  }
])


//----------------------
//Frequent_repairs
//----------------------
db.frequent_repairs.insertMany([
    {
        model_id: ObjectId("648fb7b1bc52811108db38a8"),
        quantity_repairs: 50
    },
    {
        model_id: ObjectId("648fb7b1bc52811108db38a9"),
        quantity_repairs: 120
    },
    {
        model_id: ObjectId("648fb7b1bc52811108db38aa"),
        quantity_repairs: 30
    }
])
db.technical_services.find()



//----------------------
//Locations
//----------------------
db.locations.insertMany([
  {
    technical_services_id: ObjectId("648fad93bc52811108db388d"),
    country: "Perú",
    city: "Lima",
    address: "Avenida La Escalada 1771, Oficina 401, Santiago de Surco",
    email: "info@techrepair.com"
  },
  {
    technical_services_id: ObjectId("648fad93bc52811108db388e"),
    country: "Argentina",
    city: "Buenos Aires",
    address: "Calle Corrientes 123, Microcentro",
    email: "info@smartfix.com"
  },
  {
    technical_services_id: ObjectId("648fad93bc52811108db388f"),
    country: "Chile",
    city: "Santiago",
    address: "Avenida Providencia 456, Providencia",
    email: "info@pcmaster.com"
  },
  {
    technical_services_id: ObjectId("648fad93bc52811108db3890"),
    country: "Brasil",
    city: "Sao Paulo",
    address: "Rua Paulista 789, Bela Vista",
    email: "info@gadgetfix.com"
  },
  {
    technical_services_id: ObjectId("648fad93bc52811108db3891"),
    country: "Colombia",
    city: "Bogotá",
    address: "Carrera 7 987, Centro",
    email: "info@electrofix.com"
  }
])
db.clients.find()




//----------------------
//Reviews
//----------------------
db.reviews.insertMany([
  {
    client_id: ObjectId("648fb274bc52811108db3897"),
    technical_services_id: ObjectId("648fad93bc52811108db3891"),
    comment: "¡Excelente servicio! Rápido y eficiente.",
    score: 4.5
  },
  {
    client_id: ObjectId("648fb60dbc52811108db389e"),
    technical_services_id: ObjectId("648fad93bc52811108db3891"),
    comment: "No quedé satisfecho con la reparación. Tuvieron que hacer ajustes adicionales.",
    score: 2.0
  },
  {
    client_id: ObjectId("648fb612bc52811108db38a0"),
    technical_services_id: ObjectId("648fad93bc52811108db3891"),
    comment: "Buen trato al cliente, pero la reparación tomó más tiempo del esperado.",
    score: 3.8
  }
])

db.reviews.find()
