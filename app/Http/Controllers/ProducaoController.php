<?php

namespace App\Http\Controllers;

use App\Models\Producao;
use Illuminate\Http\Request;

class ProducaoController extends Controller
{
    public function index()
    {
        return Producao::all();
    }

    public function store(Request $request)
    {
        $request->validate([
            'descricao' => 'required|string|max:255',
            'quantidade' => 'required|numeric',
            'data_inicio' => 'required|date',
            'data_fim' => 'nullable|date',
        ]);

        $producao = Producao::create([
            'descricao' => $request->descricao,
            'quantidade' => $request->quantidade,
            'data_inicio' => $request->data_inicio,
            'data_fim' => $request->data_fim,
        ]);

        return response()->json($producao, 201);
    }

    public function show($id)
    {
        $producao = Producao::findOrFail($id);

        return response()->json($producao);
    }

    public function update(Request $request, $id)
    {
        $producao = Producao::findOrFail($id);

        $request->validate([
            'descricao' => 'required|string|max:255',
            'quantidade' => 'required|numeric',
            'data_inicio' => 'required|date',
            'data_fim' => 'nullable|date',
        ]);

        $producao->update([
            'descricao' => $request->descricao,
            'quantidade' => $request->quantidade,
            'data_inicio' => $request->data_inicio,
            'data_fim' => $request->data_fim,
        ]);

        return response()->json($producao);
    }

    public function destroy($id)
    {
        $producao = Producao::findOrFail($id);
        $producao->delete();

        return response()->json(null, 204);
    }
}
