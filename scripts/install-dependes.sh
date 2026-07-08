#!/usr/bin/env bash
# =============================================================
# install-depends.sh
# Instala todas as dependências do projeto MinhaApiRest
# Compatível com .NET 8
# Uso: bash install-depends.sh (na raiz da solution)
# =============================================================

set -e  # para o script se qualquer comando falhar

echo "📦 Instalando dependências — MinhaApiRest (.NET 8)"
echo "======================================================"

# --------------------------------------------------------------
# Application — MediatR 14 (sem o pacote legado Extensions)
# AddMediatR já vem embutido no MediatR a partir da v12
# --------------------------------------------------------------
echo ""
echo "▶ Application"
dotnet add MinhaApiRest.Application package MediatR --version 14.1.0
dotnet add MinhaApiRest.Application package FluentValidation --version 11.9.0
dotnet add MinhaApiRest.Application package AutoMapper --version 13.0.1
# --------------------------------------------------------------
# Infra — EF Core + SQL Server
# OBS: Microsoft.EntityFrameworkCore (base) NÃO precisa ser
# instalado separadamente — já vem como dependência do SqlServer
# --------------------------------------------------------------
echo ""
echo "▶ Infra"
dotnet add MinhaApiRest.Infra package Pomelo.EntityFrameworkCore.MySql --version 8.0.0
dotnet add MinhaApiRest.API package Pomelo.EntityFrameworkCore.MySql --version 8.0.0
# --------------------------------------------------------------
# API — EF Core (para AddDbContext/UseSqlServer no Program.cs)
# MediatR não precisa ser instalado aqui — o registro via
# AddMediatR usa o Assembly do Application
# --------------------------------------------------------------
echo ""
echo "▶ API"
dotnet add MinhaApiRest.API package Microsoft.EntityFrameworkCore.SqlServer --version 8.0.0
dotnet add MinhaApiRest.API package Microsoft.EntityFrameworkCore.Design --version 8.0.0
dotnet add MinhaApiRest.API package Swashbuckle.AspNetCore --version 6.6.1
dotnet add MinhaApiRest.API package Pomelo.EntityFrameworkCore.MySql --version 8.0.0

# --------------------------------------------------------------
# Restaurar e validar
# --------------------------------------------------------------
echo ""
echo "▶ Restaurando e validando o build..."
dotnet restore
dotnet build

echo ""
echo "Tudo instalado com sucesso!"