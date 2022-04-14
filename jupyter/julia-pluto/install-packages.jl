using Pkg

pkg"update"

# pin WebIO
#Pkg.add(PackageSpec(name="WebIO", version="0.8.15"))
#Pkg.instantiate()

pkgs = getfield.(filter(p -> p.is_direct_dep, collect(values(Pkg.dependencies()))), :name)

Threads.@threads for p in pkgs
  try
    run(`$(Base.julia_cmd()) --project -e "import $p"`)
  catch e
    println("Ignoring error $e when importing package $p")
  end
end
