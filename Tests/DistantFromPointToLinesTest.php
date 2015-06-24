<?php

class DistantFromPointToLinesTest extends \PHPUnit_Framework_TestCase
{
    const DATABASE_USERNAME = 'username';
    const DATABASE_NAME = 'test';
    const DATABASE_PASSWORD = 'password';
    const DATABASE_HOSTNAME = 'hostname';
    protected function setUp()
    {
        $this->db = new PDO(
            'mysql:host='.self::DATABASE_HOSTNAME.';dbname='.self::DATABASE_NAME,
            self::DATABASE_USERNAME,
            self::DATABASE_PASSWORD);
    }
    
    public function testDistance()
    {
        $this->assertEquals((float)$this->db->query("select DistantFromPointToLines(GeomFromText('LineString(1 1,2 2,3 3)', Point(0,1)) as RESULT")[0]['RESULT'], 1);
        $this->assertEquals((float)$this->db->query("select DistantFromPointToLines(GeomFromText('LineString(1 1,2 2,3 3)', Point(1,1)) as RESULT")[0]['RESULT'], 0);
        $this->assertEquals((float)$this->db->query("select DistantFromPointToLines(GeomFromText('LineString(1 1,2 2,3 3)', Point(4,4)) as RESULT")[0]['RESULT'], sqrt(2));
    }
}
