herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

% 1
tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(egon, sopapa).
tiene(egon, bordea).
tiene(peter, trapeador).
tiene(winston, varitaDeNeutrones).

% 2
tieneLaHerramienta(CazaFantasma, aspiradora(Potencia)):-
    tiene(CazaFantasma, aspiradora(PotenciaPropia)),
    Potencia =< PotenciaPropia.

tieneLaHerramienta(CazaFantasma, Herramienta):-
    tiene(CazaFantasma, Herramienta).

% 3
puedeRealizarTarea(CazaFantasma, Tarea):-
    tiene(CazaFantasma, varitaDeNeutrones),
    herramientasRequeridas(Tarea, _).

puedeRealizarTarea(CazaFantasma, Tarea):-
    tiene(CazaFantasma, _),
    herramientasRequeridas(Tarea, Herramientas),
    forall(member(Herramienta, Herramientas), tieneLaHerramienta(CazaFantasma, Herramienta)).

% 4
tareaPedida(casper, limpiarBanio, 3).
tareaPedida(casper, costarPasto, 10).
precio(limpiarBanio, 20).
precio(costarPasto, 1000).

cobroClientePorTarea(Cliente, Tarea, Precio):-
    tareaPedida(Cliente, Tarea, CantMetrosCuadrados),
    precio(Tarea, PrecioPorMetroCuadrado),
    Precio is CantMetrosCuadrados * PrecioPorMetroCuadrado.

cobroACliente(Cliente, [Tarea], Precio):-
    cobroClientePorTarea(Cliente, Tarea, Precio).
cobroACliente(Cliente, [Tarea|TareasSiguientes], PrecioFinal):-
    cobroClientePorTarea(Cliente, Tarea, PrecioActual),
    cobroACliente(Cliente, TareasSiguientes, PrecioSiguiente),
    PrecioFinal is PrecioActual + PrecioSiguiente.
