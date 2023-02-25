<?php

namespace AddCar\Models;

use AddCar\DB\DBConnection;
use Exception;
use JsonSerializable;
use PDO;


class Evento extends Modelo implements JsonSerializable
{

    /** @var string La tabla contra la que mapea la clase. */
    protected $table = "eventos";
    /** @var string La primary key. */
    protected $pk = "id_evento";

    protected $id_evento;
    protected $titulo;
    protected $cuerpo;
    protected $fecha;
    protected $id_usuario;
    protected $imagen;
    protected $localizacion;
    protected $userimg;
    protected $username;

    /** @var array Lista de los atributos que permitidos cargar en nuestra clase. */
    protected $atributosPermitidos = [
        'id_evento', 
        'titulo', 
        'cuerpo', 
        'fecha', 
        'id_usuario', 
        'imagen', 
        'localizacion',
        'userimg',
        'username'
    ];

    public function jsonSerialize()
    {
        return [
            'id_evento' => $this->getIdEvento(),
            'titulo' => $this->getTitulo(),
            'cuerpo' => $this->getCuerpo(),
            'fecha' => $this->getFecha(),
            'imagen' => $this->getImagen(),
            'id_usuario' => $this->getIdUsuario(),
            'localizacion' => $this->getLocalizacion(),
            'userimg' => $this->getuserimg(),
            'username' => $this->getUsername(),
        ];
    }
    /**
     * Carga todos los datos provistos en $data en las propiedades de la instancia, siempre y cuando figuren en la propiedad $atributosPermitidos.
     *
     * @param array $data
     */
    public function massAssignament(array $data)
    {
        foreach($this->atributosPermitidos as $attr) {
            if(isset($data[$attr])) {
                $this->{$attr} = $data[$attr];
            }
        }
    }
    /**
     * Carga los datos del posteo en base al $id provisto.
     *
     * @param $email
     * @return null|Usuario
     */
    public function todos()
    {
        $db = DBConnection::getConnection();

        $query = "select e.*, 
                    u.imagen as userimg, 
                    u.usuario as username,
                    u.email as useremail
                from eventos e
                inner join usuarios u
                on e.id_usuario = u.id 
                ORDER By fecha ASC;";

        $stmt = $db->prepare($query);
        $stmt->execute();

        $salida = [];
        while ($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $evento = new Evento;
            $evento->massAssignament($fila);
            $salida[] = $evento;
        }
        return $salida;
    }

    public function traerEvento($id)
    {
        $db = DBConnection::getConnection();
        
        $query = "
            SELECT e.*, 
                u.imagen as userimg, 
                u.usuario as username
            FROM eventos e
            INNER JOIN usuarios u 
                on e.id_usuario = u.id
            WHERE e.id_evento = ?";

        $stmt = $db->prepare($query);
        $stmt->execute([$id]);

        if($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {

            $evento = new self;
            $evento->id_evento = (int) $fila['id_evento'];
            $evento->titulo = $fila['titulo'];
            $evento->cuerpo = $fila['cuerpo'];
            $evento->id_usuario = (int) $fila['id_usuario'];
            $evento->fecha = $fila['fecha'];
            $evento->localizacion = $fila['localizacion'];
            $evento->imagen = $fila['imagen'];
            $evento->userimg = $fila['userimg'];
            $evento->username = $fila['username'];

            return $evento;
        }

        return null;
    }

    public function traerEventosPorUsuario($id_usuario)
    {
        $db = DBConnection::getConnection();

        $query = "
                SELECT e.*, u.imagen as userimg, u.usuario as username
                FROM eventos e
                INNER JOIN usuarios u on e.id_usuario = u.id
                WHERE id_evento = ?;";

        $stmt = $db->prepare($query);
        $stmt->execute([$id_usuario]);

        $salida = [];

        while ($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $evento = new Evento;
            $evento->massAssignament($fila);
            $salida[] = $evento;
        }
        
        return $salida;
    }


    /**
     * Crea un registro en la tabla con la $data proporcionada.
     *
     * @param array $data
     * @throws Exception
     */
    public function crear(array $data)
    {
        $db = DBConnection::getConnection();
        $query = "INSERT INTO eventos (titulo, cuerpo, fecha, id_usuario)
              VALUES (:titulo, :cuerpo, :fecha, :id_usuario)";
        $query = "INSERT INTO `eventos`(`titulo`, `fecha`, `cuerpo`, `id_usuario`, `imagen`, `localizacion`) 
                    VALUES (':titulo',':fecha',':cuerpo',':id_usuario',':imagen',':localizacion')";

        $stmt = $db->prepare($query);
        $exito = $stmt->execute([
            'titulo' => $data['titulo'],
            'cuerpo' => $data['cuerpo'],
            'fecha' => date("Y-m-d"),
            'id_usuario' => $data['id_usuario'],
            'imagen' => $data['imagen'],
            'localizacion' => $data['localizacion'],
        ]);

        if(!$exito) {
            throw new Exception('No se pudo crear el Evento.');
        }

        $data['id_evento'] = $db->lastInsertId();
        $this->massAssignament($data);
    }

    /**
     * @return mixed
     */
    public function getIdEvento()
    {
        return $this->id_evento;
    }

    /**
     * @param mixed $id_evento
     */
    public function setIdEvento($id_evento)
    {
        $this->id_evento = $id_evento;
    }

    /**
     * @return mixed
     */
    public function getTitulo()
    {
        return $this->titulo;
    }

    /**
     * @param mixed $titulo
     */
    public function setTitulo($titulo)
    {
        $this->titulo = $titulo;
    }

    /**
     * @return mixed
     */
    public function getFecha()
    {
        return $this->fecha;
    }

    /**
     * @param mixed $fecha
     */
    public function setFecha($fecha)
    {
        $this->fecha = $fecha;
    }


    /**
     * @return mixed
     */
    public function getCuerpo()
    {
        return $this->cuerpo;
    }

    /**
     * @param mixed $cuerpo
     */
    public function setCuerpo($cuerpo)
    {
        $this->cuerpo = $cuerpo;
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
    public function getImagen()
    {
        return $this->imagen;
    }

    /**
     * @param mixed $imagen
     */
    public function setImagen($imagen)
    {
        $this->imagen = $imagen;
    }

    /**
     * @return mixed
     */
    public function getLocalizacion()
    {
        return $this->localizacion;
    }

    /**
     * @param mixed $localizacion
     */
    public function setLocalizacion($localizacion)
    {
        $this->localizacion = $localizacion;
    }
    /**
     * @return mixed
     */
    public function getuserimg()
    {
        return $this->userimg;
    }

    /**
     * @param mixed $userimg
     */
    public function setuserimg($userimg)
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