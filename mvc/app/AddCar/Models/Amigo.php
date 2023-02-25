<?php

namespace AddCar\Models;

use AddCar\DB\DBConnection;
use Exception;
use JsonSerializable;
use PDO;


class Amigo extends Modelo implements JsonSerializable
{
    /** @var string La tabla contra la que mapea la clase. */
    protected $table = "amigos";

    protected $id_usuario;
    protected $id_amigo;
    protected $status;
    protected $userimg;
    protected $username;



    /** @var array Lista de los atributos que permitidos cargar en nuestra clase. */
    protected $atributosPermitidos = [
        'id_usuario',
        'id_amigo',
        'status',
        'userimg',
        'username'
    ];

    public function jsonSerialize()
    {
        return [
            'id_usuario' => $this->getIdUsuario(),
            'id_amigo' => $this->getIdAmigo(),
            'status' => $this->getStatus(),
            'userimg' => $this->getUserImg(),
            'username' => $this->getUserName(),
        ];
    }

    /**
     * Carga todos los datos provistos en $data en las propiedades de la instancia, siempre y cuando figuren en la propiedad $atributosPermitidos.
     *
     * @param array $data
     */
    public function massAssignament(array $data)
    {
        foreach ($this->atributosPermitidos as $attr) {
            if (isset($data[$attr])) {
                $this->{$attr} = $data[$attr];
            }
        }
    }

    /**
     * Retorna un array con todos los amigos.
     * Cada amigo va a esta representado como una instancia de amigo.
     *
     * @return Amigo[]
     */
    public function traerAmigosPorUsuario($id_usuario)
    {
        $db = DBConnection::getConnection();

        $query = "
                SELECT a.*, u.usuario as username, u.imagen as userimg 
                FROM amigos a
                INNER JOIN usuarios u on u.id = a.id_amigo
                where a.id_usuario = ?
                ";

        $stmt = $db->prepare($query);
        $stmt->execute([$id_usuario]);

        $salida = [];

        while ($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $amigo = new Amigo;
            $amigo->massAssignament($fila);
            $salida[] = $amigo;
        }

        return $salida;
    }

    /**
     * Crea un registro en la tabla con la $data proporcionada.
     *
     * @param array $data
     * @param int $id
     * @throws Exception
     */
    public function crear($id, array $data)
    {

        $db = DBConnection::getConnection();
        $query = "INSERT INTO comentarios (cuerpo, fecha, id_usuario)
              VALUES (:cuerpo, :fecha, :id_usuario)";

        $stmt = $db->prepare($query);
        $exito = $stmt->execute([
            'cuerpo' => $data['cuerpo'],
            'id_usuario' => $data['id_usuario'],
            'fecha' => date("Y-m-d H:i:s")
        ]);


        if (!$exito) {
            throw new Exception('No se pudo crear el Comentario.');
        }

        $data['id'] = $db->lastInsertId();

        $this->massAssignament($data);
        //$this->cargarTablaPosteosHasComentarios($id, $data['id']);
    }

    /**
     * @return mixed
     */
    public function getIdUsuario()
    {
        return $this->id_usuario;
    }

    /**
     * @param mixed $id_usuario
     */
    public function setIdUsuario($id_usuario)
    {
        $this->id_usuario = $id_usuario;
    }

    /**
     * @return mixed
     */
    public function getIdAmigo()
    {
        return $this->id_amigo;
    }

    /**
     * @param mixed $id_amigo
     */
    public function setIdEvento($id_amigo)
    {
        $this->id_amigo = $id_amigo;
    }
    /**
     * @return mixed
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * @param mixed $status
     */
    public function setStatus($status)
    {
        $this->status = $status;
    }

    
    /**
     * @return mixed
     */
    public function getUserImg()
    {
        return $this->userimg;
    }

    /**
     * @param mixed $userimg
     */
    public function setUserImg($userimg)
    {
        $this->userimg = $userimg;
    }/**
     * @return mixed
     */
    public function getUsername()
    {
        return $this->username;
    }

    /**
     * @param mixed $username
     */
    public function setUsername($username)
    {
        $this->username = $username;
    }

}