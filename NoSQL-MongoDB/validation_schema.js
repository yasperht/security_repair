// Created Database
use project_security_repair

//Create Collections
//db.createCollection("clients")
//db.createCollection("devices")
//db.createCollection("languages")
//db.createCollection("frequent_repairs")
//db.createCollection("technical_services")
//db.createCollection("brands")
//db.createCollection("models")
//db.createCollection("locations")
//db.createCollection("reviews")

//----------------------------
// Created Schema Validation
//----------------------------

db.createCollection("clients", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["name", "first_lastname", "username", "email", "password"],
            properties: {
                name: {
                    bsonType: "string"
                },
                first_lastname: {
                    bsonType: "string"
                },
                username: {
                    bsonType: "string"
                },
                email: {
                    bsonType: "string",
                    pattern: "^(\\w+)(\\.\\w+)*@(gmail\\.com|hotmail\\.com)$",
                    description: "Solo se puede usar dominios de correo @gmail.com o @hotmail.com"
                },
                password:{
                    bsonType: "string",
                    pattern: "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()-=_+]).{8,12}$",
                    description: "La contraseña debe tener combinación de caracteres especiales, números y mayúsculas"
                }
            }
        }
    }
})

// Schema Modify
db.runCommand({
    collMod: "clients",
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["name", "first_lastname", "username", "email", "password"],
            properties: {
                name: {
                    bsonType: "string"
                },
                first_lastname: {
                    bsonType: "string"
                },
                username: {
                    bsonType: "string"
                },
                email: {
                    bsonType: "string",
                    pattern: "^(\\w+)(\\.\\w+)*@(gmail\\.com|hotmail\\.com)$",
                    description: "Solo se puede usar dominios de correo @gmail.com o @hotmail.com"
                },
                password:{
                    bsonType: "string",
                    pattern:  "^(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()-=_+]).{8,12}$",
                    description: "La contraseña debe tener combinación de caracteres especiales, números y mayúsculas"
                }
            }
        }
    }
})

db.createCollection("devices", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["name"],
            properties: {
                name: {
                    bsonType: "string"
                }
            }
        }
    }
})

db.createCollection("languages", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["name"],
            properties: {
                name: {
                    bsonType: "string"
                }
            }
        }
    }
})

db.createCollection("frequent_repairs", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["model_id", "quantity_repairs"],
            properties: {
                model_id: {
                    bsonType: "objectId",
                    description: "Referencia a un modelo específico"
                },
                quantity_repairs: {
                    bsonType: "int"
                }
            }
        }
    }
})

db.createCollection("technical_services", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name", "description", "repairs_available", "hours_attention"],
      properties: {
        name: {
            bsonType: "string"
        },
        description: {
            bsonType: "string"
        },
        repairs_available: {
          bsonType: "object",
          required: ["devices_id", "brands_id"],
          properties: {
            devices_id: {
              anyOf: [
                  {
                      bsonType: "array",
                      items: { bsonType: "objectId"},
                      minItems: 1
                  },
                  { bsonType: "objectId"}
              ]
            },
            brands_id: {
              anyOf: [
                {
                    bsonType: "array",
                    items: { bsonType: "objectId" },
                    minItems: 1
                },
                { bsonType: "objectId" }
              ]
            }
          }
        },
        hours_attention: {
          bsonType: "array",
          items: { bsonType: "string" },
          minItems: 1
        }
      }
    }
  }
})

db.createCollection("brands", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["name"],
            properties: {
                name: {
                    bsonType: "string"
                }
            }
        }
    }
})

db.createCollection("models", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["name", "brand_id"],
            properties:{
                name: {
                    bsonType: "string",

                },
                brand_id: {
                    bsonType: "objectId"
                },
            }
        }
    }
})


db.createCollection("locations", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["technical_services_id", "country", "city", "address", "email"],
            properties: {
                technical_services_id: {
                    bsonType: "objectId"
                },
                country: {
                     bsonType: "string"
                },
                city: {
                     bsonType: "string"
               },
               address:{
                     bsonType: "string"
               },
               email: {
                    bsonType: "string"
               }
            }
        }
    }
})

db.createCollection("reviews", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["client_id", "technical_services_id", "comment"],
            properties: {
                client_id: {
                    bsonType: "objectId"
                },
                technical_services_id: {
                    bsonType: "objectId"
                },
                comment: {
                    bsonType: "string"
                }
            }
        }
    }
})



