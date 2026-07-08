# dotnet clean → remove os artefatos de build conhecidos (mas às vezes deixa lixo de versões antigas, por isso o próximo passo).
# rm -rf MinhaApiRest.API/bin MinhaApiRest.API/obj → apaga na força bruta as pastas bin (binários + arquivos copiados, incluindo aquele appsettings.Development.json velho) e obj (cache intermediário do build). Isso garante que não sobra nenhum arquivo órfão de builds anteriores.
# dotnet build MinhaApiRest.slnx → recompila o projeto do zero, recriando a pasta bin e copiando a versão atual dos seus arquivos appsettings.*.json, já que o .csproj tem a regra CopyToOutputDirectory.


dotnet clean
rm -rf MinhaApiRest.API/bin MinhaApiRest.API/obj
dotnet build MinhaApiRest.slnx