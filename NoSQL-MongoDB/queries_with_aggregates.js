//----------------------------
// Aggregate Queries
//----------------------------

/*
-> Podemos procesar datos de una forma compleja.
-> Son un conjunto de etapas o procesos donde se realizan diferentes operaciones, filtros, transformaciones, etc.

    Aggregations: [ {etapa1}, {etapa2} ... ]
    Aggregations: Acostumbra a ir más lentas


ETAPAS:
    1. $group (para agrupar diferentes documento en uno)
    2. $match (para filtrar documentos)
    3. $lookup (para buscar información en otras colecciones)
    4. $project (para dejar pasar solamente un set de atributos)
    5. unwind (para desmontar arrays y transformar en un documento único por item del array)
*/
db.technical_services.find()

//Encontrar cuantos score tienen los servicios técnicos
db.technical_services.aggregate([
    {
        $group:{
            _id: "$score",
            quantity: {$sum: 1}
        }
    }
])

db.reviews.find()

//Cuantas reseñas ha recibido los servicios técnicos
db.reviews.aggregate([
    {
        $group: {
            _id: "$technical_services_id",
            quantity: {$sum: 1}
        }
    },
    {
        $sort: {
            quantity: -1
        }
    }
])


//Mostrar la calificación(score) media que tiene cada servicio técnico

db.reviews.aggregate([
    {
        $group: {
           _id: "$technical_services_id",
           quantity: {$avg: "$score"}
        }
    },
    {
        $sort:{
            quantity: -1
        }
    },
])

//Calcular la cantidad de reseñas por servicio técnico y mostrar la media de sus calificaciones (score)
db.reviews.aggregate([
    {
        $group: {
           _id: "$technical_services_id",
           quantity: {$sum: 1},
           average: {$avg: "$score"}
        }
    },
    {
        $sort:{
            quantity: -1
        }
    },
])

/*Calcular la cantidad de reseñas de los servicio técnicos que tengan una calificación mayor o igual a 4.5
y mostrar la media de sus calificaciones (score)*/

db.reviews.aggregate([
    {
        $match: {
            score: {$gte: 4.5}
        }
    },
    {
        $group: {
            _id: "$technical_services_id",
            quantity: {$sum: 1},
            average: {$avg: "$score"}
        }
    },
    {
        $sort: {
            average: -1
        }
    }
])

//Listar los nombres y la calificación media de los servicios técnicos

db.reviews.find()
db.technical_services.find()

db.reviews.aggregate([
    {
        $lookup:{
            from: "technical_services",
            localField: "technical_services_id",
            foreignField: "_id",
            as: "technical"
        }
    }
])

db.reviews.find()
db.reviews.aggregate([
    {
        $match: {
            score: {$lt: 4.5}
        }
    },
        {
        $group:{
            _id: "$technical_services_id",
            average: {$avg: "$score"}
        }
    },
     {
        $lookup:{
            from: "technical_services",
            localField: "_id",
            foreignField: "_id",
            as: "technical"
        }
    },
    {
        $unwind: {
            path: "$technical" //separa el array de la union de reviews con technical_services
        }
    },
    {
        $project: {
            technical_service: "$technical.name",
            _id: 0,
            average: 1,
            quantity: 1
        }
    },
    {
        $sort: {
            average: -1
        }
    }
])



//-------------------
// Aditional Queries
//-------------------

//Listar a los servicios técnicos que esten en Argentina y en la ciudad de Buenos Aires
db.locations.find()
db.technical_services.find()

db.locations.aggregate([
    {
        $match: {
            country: "Argentina",
            city: "Buenos Aires"
        }
    },
    {
       $lookup: {
            from: "technical_services",
            localField: "technical_services_id",
            foreignField: "_id",
            as: "technical"
       }
    },
    {
        $unwind: {
            path: "$technical"
        }
    },
    {
        $project: {
            technical_service: "$technical.name",
            country: 1,
            city: 1,
            _id: 0
        }
    }
])



//Listar todos los servicios técnicos que contengan con "Tech"
db.technical_services.find({name: /Tech/})

db.technical_services.aggregate([
    {
       $match: {
            name: /Tech/
       }
    },
    {
        $sort: {
            name: -1
        }
    },
    {
        $project: {
            name: 1,
            description: 1,
            hours_attention: 1,
            _id: 0
        }
    }
])

// Cuales son los equipos que se han reparado más frecuentemente
db.frequent_repairs.aggregate([
    {
       $lookup: {
            from: "models",
            localField: "model_id",
            foreignField: "_id",
            as: "device"
       }
    },
    {
      $unwind: {
        path: "$device"
      }
    },
    {
        $project: {
            device_name: "$device.name",
            quantity_repairs: 1,
             _id: 0
        }
    },
    {
        $sort: {
            quantity_repairs: -1
        }
    }
])


//Listar a los clientes que han reparado sus equipos con el servicio técnico SmartFix
db.technical_services.find()

db.clients.aggregate([
    {
        $match: {
            technical_services_id: ObjectId("648fad93bc52811108db388e")
        }
    },
    {
        $project: {
            name: 1,
            first_lastname: 1,
            email: 1,
            _id: 0
        }
    },
    {
        $count: "total"
    }
])


//Listar a los servicios técnicos que atienden de Lunes - Viernes: 8:00 am - 6:00 pm"
db.technical_services.find()

db.technical_services.aggregate([
    {
        $match: {
            hours_attention: "Lunes - Viernes: 8:00 am - 6:00 pm"
        }
    },
    {
        $project: {
            _id: 0,
            name: 1,
            hours_attention: 1
        }
    }
])

db.locations.find()

//Listar todos los servicios técnicos que tengan sede en Perú
db.locations.aggregate([
    {
        $match: {
            country: "Perú"
        }
    },
    {
        $lookup:{
            from: "technical_services",
            localField: "technical_services_id",
            foreignField: "_id",
            as: "technical"
        }
    },
    {
       $unwind: {
          path: "$technical"
       }
    },
    {
        $project: {
            technical_service: "$technical.name",
            _id: 0,
            country: 1
        }
    }
])


//Listar los modelos de equipos de la marca Asus

db.models.find()
db.models.aggregate([
    {
        $lookup: {
            from: "brands",
            localField: "brand_id",
            foreignField: "_id",
            as: "device"
       }
    },
    {
        $unwind: {
            path: "$device"
        }
    },
    {
        $match: {
            "device.name": "Asus"
        }
    },
    {
        $project:{
            _id: 0,
            name: 1,
            device: 1
        }
    }
])
