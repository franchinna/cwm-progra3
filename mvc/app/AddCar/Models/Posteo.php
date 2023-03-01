<?php

namespace AddCar\Models;

use AddCar\DB\DBConnection;
use Exception;
use JsonSerializable;
use PDO;


class Posteo extends Modelo implements JsonSerializable
{

    /** @var string La tabla contra la que mapea la clase. */
    protected $table = "posteos";
    /** @var string La primary key. */
    protected $pk = "id_posteo";

    protected $id_posteo;
    protected $titulo;
    protected $cuerpo;
    protected $fecha;
    protected $email;
    protected $id_usuario;
    protected $userimg;
    protected $username;

    /** @var array Lista de los atributos que permitidos cargar en nuestra clase. */
    protected $atributosPermitidos = [
        'id_posteo',
        'titulo',
        'cuerpo',
        'fecha',
        'id_usuario',
        'email',
        'userimg',
        'username'
    ];

    public function jsonSerialize()
    {
        return [
            'id_posteo' => $this->getIdPosteo(),
            'titulo' => $this->getTitulo(),
            'cuerpo' => $this->getCuerpo(),
            'fecha' => $this->getFecha(),
            'id_usuario' => $this->getIdUsuario(),
            'email' => $this->getEmail(),
            'userimg' => $this->getUserImg(),
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
        foreach ($this->atributosPermitidos as $attr) {
            if (isset($data[$attr])) {
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

        $query = "select p.*, 
                    u.email as email, 
                    u.imagen as userimg, 
                    u.usuario as username
                from posteos p
                inner join usuarios u
                on p.id_usuario = u.id 
                ORDER By fecha ASC;";

        $stmt = $db->prepare($query);
        $stmt->execute();

        $salida = [];
        while ($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $posteo = new Posteo;
            $posteo->massAssignament($fila);
            $salida[] = $posteo;
        }
        return $salida;
    }

    public function traerPosteo($id)
    {
        $db = DBConnection::getConnection();

        $query = "select p.*,
                        u.email,
                        u.usuario,
                        u.imagen
                from posteos p
                inner join usuarios u
                on p.id_usuario = u.id
                where p.id_posteo = ?";

        $stmt = $db->prepare($query);
        $stmt->execute([$id]);

        if ($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {

            $posteo = new self;
            $posteo->id_posteo = (int) $fila['id_posteo'];
            $posteo->titulo = $fila['titulo'];
            $posteo->cuerpo = $fila['cuerpo'];
            $posteo->id_usuario = (int) $fila['id_usuario'];
            $posteo->fecha = $fila['fecha'];
            $posteo->email = $fila['email'];
            $posteo->userimg = $fila['imagen'];
            $posteo->username = $fila['usuario'];

            return $posteo;
        }
        return null;
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
        $query = "INSERT INTO posteos (titulo, cuerpo, fecha, id_usuario)
              VALUES (:titulo, :cuerpo, :fecha, :id_usuario)";

        $stmt = $db->prepare($query);
        $exito = $stmt->execute([
            'titulo' => $data['titulo'],
            'cuerpo' => $data['cuerpo'],
            'fecha' => date("Y-m-d"),
            'id_usuario' => $data['id_usuario']
        ]);

        if (!$exito) {
            throw new Exception('No se pudo crear el Posteo.');
        }

        $data['id_posteo'] = $db->lastInsertId();
        $this->massAssignament($data);
    }

    /**
     * Retorna un array con todos los amigos.
     * Cada amigo va a esta representado como una instancia de Usuario.
     *
     * @return Amigo[]
     */
    public function listarMisPosteos($id_usuario)
    {
        $db = DBConnection::getConnection();

        $query = "select *
                    from posteos
                    where id_usuario = ?;";

        $stmt = $db->prepare($query);
        $stmt->execute([$id_usuario]);

        $salida = [];

        while ($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $posteo = new Posteo;
            $posteo->massAssignament($fila);
            $salida[] = $posteo;
        }

        return $salida;
    }

    /**
     * Retorna un array con todos los amigos.
     * Cada amigo va a esta representado como una instancia de Usuario.
     *
     * @return Amigo[]
     */
    public function listarPosteosAmigos($id_usuario)
    {
        $db = DBConnection::getConnection();

        $query = "select p.*, u.usuario as username, u.imagen as userimg
                from posteos p
                inner join amigos a on p.id_usuario = a.id_amigo
                inner join usuarios u on u.id = p.id_usuario
                    where a.id_usuario = ? AND a.status != 0 AND a.status = 1";

        $stmt = $db->prepare($query);
        $stmt->execute([$id_usuario]);

        $salida = [];

        while ($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $posteo = new Posteo;
            $posteo->massAssignament($fila);
            $salida[] = $posteo;
        }

        return $salida;
    }

    /**
     * @return mixed
     */
    public function getIdPosteo()
    {
        return $this->id_posteo;
    }

    /**
     * @param mixed $id_posteo
     */
    public function setIdPosteo($id_posteo)
    {
        $this->id_posteo = $id_posteo;
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
    public function getEmail()
    {
        return $this->email;
    }

    /**
     * @param mixed $email
     */
    public function setEmail($email)
    {
        $this->email = $email;
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
    }
    /**
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
