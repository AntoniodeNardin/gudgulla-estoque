<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Unidade extends Model
{
    use HasFactory;

    protected $fillable = ['unidade'];

    public function itens()
    {
        return $this->hasMany(Item::class, 'unidade_id');
    }
}
