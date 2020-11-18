function obstacles = get_space(axis)
    x = axis.x / axis.step + 1;
    y = axis.y / axis.step + 1;
    z = axis.z / axis.step + 1;

    obstacles = zeros(x, y, z);
end

