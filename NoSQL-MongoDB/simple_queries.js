//----------------------------
// Simple Queries
//----------------------------

// Buscar a un servicio técnico por su nombre específico.
db.technical_services.find({
    name: "Wiltech"
})

// Buscar todas la reseñas que tengan un score = 4.9
db.reviews.find({
    score: 4.9
})

// Buscar todas la reseñas que tengan un score menor o igual a 3.2
db.reviews.find({
    score: {
        //Aquí se coloca los requisitos que "score" debe cumplir.
        //Se ingresarán operadores de MongoDB
        //Todos los operadores de comparación en MongoDB inician con "$"

        /*
            mayor o igual --> $gte
            menor que --> $lt
            menor o igual --> $lte
            mayor que ---> $gt
            igual --> $eq

            contiene --> $in
            diferente --> $ne
            no contiene --> $nin
        */

        $lte: 3.2
    }
})

// Buscar todas la reseñas que tengan un score mayor o igual que 3.5 pero menor a 4.9
db.reviews.find({
    score: {
        $gte: 3.5,
        $lt: 4.9
    }
})

//Encontrar las ubicaciones de servicios técnicos que esten en el País de Argentina y la ciudad de Buenos Aires.
db.locations.find({
    country: "Argentina", //AND
    city: "Buenos Aires"
})


//Buscar todas los servicios técnico que no sean Wiltech ni Smartphones Perú
db.technical_services.find({
    name: {
        $ne: "Wiltech"
    }
})



/*Comparación con Array: El atributo objetivo NO debe ser un Array*/
//Buscar todos los modelos que sean de la marca Samsung y Apple
/*
    samsung_id: 648fa8e8bc52811108db3881
    apple_id: 648fa8e8bc52811108db3883
*/

db.models.find({
    brand_id: {
        $in: [ObjectId("648fa8e8bc52811108db3881"), ObjectId("648fa8e8bc52811108db3883")]
    }
})

//Buscar todos los modelos que [NO] sean de la marca Samsung y Apple
db.models.find({
    brand_id: {
        $nin: [ObjectId("648fa8e8bc52811108db3881"), ObjectId("648fa8e8bc52811108db3883")]
    }
})



/*Comparación con Array: El atributo objetivo SI debe ser un Array*/
db.technical_services.find({
    hours_attention: {
        $in: ["Lunes - Viernes: 8:00 am - 7:00 pm"]
    }
})

db.technical_services.find({
    hours_attention: {
        $in: [
            "Lunes - Viernes: 8:00 am - 7:00 pm",
            "Sábado: 10:00 am - 3:00 pm"
        ]
    }
})


/*Buscar los servicios técnicos que reparen celulares  de la marca Samsung*/
db.devices.find({
    name: "Celular"
})

db.brands.find({
    name: "Samsung"
})
/*
    device_id: 648fa7a4bc52811108db3875
    brand_id: 648fa8e8bc52811108db3881
*/

//Verificamos que servicios técnicos tiene soporte para arreglar celulares de la marca Samsung
db.technical_services.find({
    "repairs_available.devices_id": ObjectId("648fa7a4bc52811108db3875"),
    "repairs_available.brands_id": ObjectId("648fa8e8bc52811108db3881")
}).count()

db.technical_services.find().count()



/*REGEX
->Define un grupo de texto:

Todas las palabras que empiezan por Tom: /^Tom/
Todas las palabras que empiezan por Hanks: /Hanks$/
Palabras que contienen Storie: /Story/
*/

//Listar todos los servicios técnicos que empiezen con "Fix"
db.technical_services.find({name: /^Fix/})

//Listar todos los servicios técnicos que empiezen con "It"
db.technical_services.find({name: /It$/})

//Listar todos los servicios técnicos que contengan con "Tech"
db.technical_services.find({name: /Tech/})



/*Proyecciones*/
// Sirve para filtrar los campos que devolvera MongoDB.

//Listar a los servicios técnicos que esten en Argentina y en la ciudad de Buenos Aires
//Solo mostrar el país y la dirección
db.locations.find(
    {
        country: "Argentina", //AND
        city: "Buenos Aires",
    },
    {
        country: 1,
        address: 1,
        _id: 0
    }
)

db.locations.find(
    {
        country: "Argentina", //AND
        city: "Buenos Aires",
    },
    {
        country: 0,
    }
)


//Listar a todas la reseñas de los clientes, pero solo que se muestre el comment y el score
db.reviews.find(
    { },
    {
      comment: 1,
      score: 1,
      _id: 0
    }
)

/*SORT:
    1: Ascendente
    -1: Descendiente
*/

//Listar a todas la reseñas de los clientes, pero solo que se muestre el comment y el score
// Luego, ordenar los score de forma descendente.
db.reviews.find(
    { },
    {
      comment: 1,
      score: 1,
      _id: 0
    }
).sort({score: -1})

db.reviews.find(
    { },
    {
      comment: 1,
      score: 1,
      _id: 0
    }
).sort({score: -1, comment: 1})
