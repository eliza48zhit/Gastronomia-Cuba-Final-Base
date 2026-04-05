// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaCuba
 * @dev CONTRATO FINAL (35/35) de la serie Sabores de America.
 * Registro historico con Likes, Dislikes e Identificador de Base de Sofrito.
 * Nota: Codigo ASCII puro para garantizar la inmutabilidad perfecta.
 */
contract GastronomiaCuba {

    struct Plato {
        string nombre;
        string descripcion;
        string baseSofrito; // Ej: Ajo y Cebolla, Aji Cachucha, Comino, N/A
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con la Ropa Vieja
        registrarPlato(
            "Ropa Vieja", 
            "Carne de res desmechada cocinada lentamente en salsa de tomate, vino seco y especias.",
            "Aji Cachucha y Ajo"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _baseSofrito
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            baseSofrito: _baseSofrito,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory baseSofrito,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.baseSofrito, p.likes, p.dislikes);
    }
}
