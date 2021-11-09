const express = require('express'),
    router = express.Router();
const {

    tbl_danca,
} = require('../../models');


router.get('/', (req, res) => {
    tbl_danca.findAll({
        order: [
            ['hr_inicio', 'ASC'],
        ],
    }).then((result) => {
        res.json(result)
    }).catch((err) => {
        res.json(String(err))
    });
}); //Listar todos

module.exports = router