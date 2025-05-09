function trapecio_integracion_dinamica()
    % Solicitar al usuario el valor de n
    n = input('Ingrese el número de segmentos (n): ');
    
    % Límites de integración
    a = 0;
    b = 0.8;
    
    % Función original
    f = @(x) 0.2 + 25*x - 200*x.^2 + 675*x.^3 - 900*x.^4 + 400*x.^5;
    
    % Valor exacto de la integral
    I_exacta = 1.640533;
    
    % Paso h
    h = (b - a) / n;
    
    % Regla del trapecio compuesto
    x = a:h:b;
    y = f(x);
    I_aprox = (h/2) * (y(1) + 2*sum(y(2:end-1)) + y(end));
    
    % Error absoluto y porcentual
    error_abs = abs(I_exacta - I_aprox);
    error_porcentual = (error_abs / I_exacta) * 100;
    
    % Segunda derivada simbólica para el error estimado
    syms xs
    f_sym = 0.2 + 25*xs - 200*xs^2 + 675*xs^3 - 900*xs^4 + 400*xs^5;
    f2_sym = diff(f_sym, xs, 2);
    
    % Convertir a función anónima y evaluar el máximo en el intervalo
    f2 = matlabFunction(f2_sym);
    x_vals = linspace(a, b, 1000);
    max_f2 = max(abs(f2(x_vals)));
    
    % Cálculo del error estimado con regla del trapecio
    error_estimado = ((b - a)^3 / (12 * n^2)) * max_f2;
    
    % Mostrar resultados
    fprintf('\n--- Resultados ---\n');
    fprintf('Integral aproximada: %.6f\n', I_aprox);
    fprintf('Integral exacta     : %.6f\n', I_exacta);
    fprintf('Error absoluto      : %.6f\n', error_abs);
    fprintf('Error porcentual    : %.6f %%\n', error_porcentual);
    fprintf('Error estimado      : %.6f\n', error_estimado);
end