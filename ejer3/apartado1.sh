rm -rf ./cachegrind.out.*
rm -rf ./annotate_*
rm -rf ./out_*
cp ../soa.cpp ./soa.cpp
gcc -g ./soa.cpp -o soa -std=c++17
valgrind --tool=cachegrind ./soa --L1=16384,8,32 --L2=131072,8,64
cp cachegrind.out.* out_1.out
rm -rf ./cachegrind.out.*

valgrind --tool=cachegrind ./soa --L1=32768,8,32 --L2=262144,8,64
cp cachegrind.out.* out_2.out
rm -rf ./cachegrind.out.*

valgrind --tool=cachegrind ./soa --L1=32768,8,64 --L2=262144,8,64
cp cachegrind.out.* out_3.out
rm -rf ./cachegrind.out.*

cat *.out >> out_global.out
cg_annotate out_1.out --auto=yes &> ../results/ejer3/ap1_1.result
cg_annotate out_2.out --auto=yes &> ../results/ejer3/ap1_2.result
cg_annotate out_3.out --auto=yes &> ../results/ejer3/ap1_3.result
cg_annotate out_global.out --auto=yes &> ../results/ejer3/ap1_global.result
cp out_1.out ../results/ejer3/ap1_1.out_valgrind
cp out_2.out ../results/ejer3/ap1_2.out_valgrind
cp out_3.out ../results/ejer3/ap1_3.out_valgrind
cp out_global.out ../results/ejer3/ap1_global.out_valgrind

echo "Observe los resultados obtenidos e inspeccione el código con la herramienta cg_annotate. Anote
los resultados globales y observe los resultados prestando especial atención a las líneas 12 y 13."
rm -rf ./soa.dSYM
rm -rf soa
rm -rf soa.cpp
rm -rf ./out_*