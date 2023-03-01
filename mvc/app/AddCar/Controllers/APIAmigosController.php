<?php

namespace AddCar\Controllers;

use AddCar\Core\View;
use AddCar\Models\Amigo;

class APIAmigosController extends BaseAPIController
{

    public function traerAmigosPorUsuario()
    {
        $id = urlParam('id');

        $amigos = (new Amigo)->traerAmigosPorUsuario($id);
        View::renderJson([
            'data' => $amigos
        ]);
    }

    public function traerAmigosPendientesPorUsuario()
    {
        $id = urlParam('id');

        $amigos = (new Amigo)->traerAmigosPendientesPorUsuario($id);
        View::renderJson([
            'data' => $amigos
        ]);
    }

    public function traerNoAmigosPorUsuario()
    {
        $id = urlParam('id');

        $amigos = (new Amigo)->traerNoAmigosPorUsuario($id);
        View::renderJson([
            'data' => $amigos
        ]);
    }

    public function agregarAmigo()
    {
        $this->requireAuth();
        
        $id_amigo = urlParam('id_amigo');
        $id_usuario = urlParam('id_usuario');

        try {
            (new Amigo())->agregarAmigo($id_usuario, $id_amigo);
            View::renderJson([
                'success' => true
            ]);
        } catch(\Exception $e) {
            View::renderJson([
                'success' => false
            ]);
        }
    }

    public function aceptarAmigo()
    {
        $this->requireAuth();

        $id_amigo = urlParam('id_amigo');
        $id_usuario = urlParam('id_usuario');

        try {
            (new Amigo())->aceptarAmigo($id_usuario, $id_amigo);
            View::renderJson([
                'success' => true
            ]);
        } catch(\Exception $e) {
            View::renderJson([
                'success' => false
            ]);
        }
    }
    
    public function eliminarAmigo()
    {
        $this->requireAuth();

        $id_amigo = urlParam('id_amigo');
        $id_usuario = urlParam('id_usuario');

        try {
            (new Amigo())->eliminarAmigo($id_usuario, $id_amigo);
            View::renderJson([
                'success' => true
            ]);
        } catch(\Exception $e) {
            View::renderJson([
                'success' => false
            ]);
        }
    }
}
