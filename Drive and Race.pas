uses crt;

const
    H = 30;
    W = 21;
    car = 2;
    another = 0;
    back = 7;
    b = 14;
    start_hp = 3;

var
    ch: char;
    x, m, life, bonus: integer;
    road: array [0..W, 0..H] of char;
    score: int64;

procedure pause();
begin
    writeln();
    writeln();
    writeln();
    writeln();
    writeln();
    writeln();
    writeln();
    writeln();
    writeln();
    writeln();
    writeln('                                                     P A U S E');
    writeln();
    writeln('                                             Your score: ', score);
    writeln();
    writeln();
    writeln();
    writeln();
    writeln();
    writeln();
    writeln();
    writeln();
    repeat
    until(KeyPressed);
    clrscr;
end;

procedure road_refresh();
begin
    for var i := W downto 2 do
    begin
        road[0] := road[i];
        road[i] := road[i - 1];
        road[i - 1] := road[0];
    end;
    Randomize;
    for var i := 0 to H do
        road[1, i] := ' ';
    if Random(2) = 0 then
    begin
        road[1, random(H + 1)] := 'W';
    end;
    if score mod 1000 = 0 then
    begin
        bonus := random(H + 1);
        road[1, bonus] := 'á';
    end;
    road[W, x] := 'M';
end;


begin
    textbackground(back);
    clrscr;
    textcolor(another);
    repeat
        begin
            x := H div 2 + (H div 2) div 2;
            score := 1;
            life := start_hp;
            for var i := 1 to W do
                for var j := 0 to H do
                    road[i, j] := ' ';
            repeat
                begin
                    m := Milliseconds;
                    clrscr;
                    if KeyPressed then ch := ReadKey;
                    if ((ch = 'a') or (ch = 'ô')) and (x > 0) then
                    begin
                        dec(x);
                        ch := ' ';
                    end;
                    if ((ch = 'â') or (ch = 'd')) and (x < H) then
                    begin
                        inc(x);
                        ch := ' ';
                    end;
                    if ch = #13 then
                        pause();
                    
                    road_refresh();
                    for var i := 1 to W do
                    begin
                        write('                                      ||');
                        for var j := 0 to H do
                            if (W = i) and (j = x) then
                            begin
                                textcolor(car);
                                write(road[i, j]);
                                textcolor(another);
                            end else
                            if road[i, j] = 'á' then
                            begin
                                textcolor(b);
                                write(road[i, j]);
                                textcolor(another);
                            end
                            else
                                write(road[i, j]);
                        writeln('||');
                    end;
                    inc(score);
                    writeln('                                      Life:  ', life);
                    writeln('                                      Score: ', score);
                    
                    if road[W - 1, x] = 'W' then if life > 1 then dec(life) else break;
                    if road[W - 1, x] = 'á' then inc(life);
                    repeat
                    until (Milliseconds - m >= 80);
                end;
            until (ch = #27);
            clrscr();
            writeln();
            writeln();
            writeln();
            writeln();
            writeln();
            writeln();
            writeln();
            writeln();
            writeln();
            writeln('                                                 G A M E   O V E R');
            writeln();
            writeln('                                             Your score: ', score);
            writeln();
            writeln('                                             Press "Enter" to continue');
            writeln('                                             Press sth else to exit');
            writeln();
            writeln();
            writeln();
            writeln();
            writeln();
            writeln();
            writeln();
        end;
    until (ReadKey <> #13);
end.