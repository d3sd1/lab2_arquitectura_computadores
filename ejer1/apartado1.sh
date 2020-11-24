rm -rf ./cachegrind.out.*
rm -rf ./annotate_*
rm -rf ./out_*
cp ../loop_merge.cpp ./loop_merge.cpp
gcc -g ./loop_merge.cpp -o loop_merge -std=c++17
valgrind --tool=cachegrind ./loop_merge --L1=16384,8,32 --L2=131072,8,64
cp cachegrind.out.* out_1.out
rm -rf ./cachegrind.out.*

valgrind --tool=cachegrind ./loop_merge --L1=32768,8,32 --L2=262144,8,64
cp cachegrind.out.* out_2.out
rm -rf ./cachegrind.out.*

valgrind --tool=cachegrind ./loop_merge --L1=32768,8,64 --L2=262144,8,64
cp cachegrind.out.* out_3.out
rm -rf ./cachegrind.out.*

cg_annotate out_1.out --auto=yes &> ../results/ejer1/ap1_1.result
cg_annotate out_2.out --auto=yes &> ../results/ejer1/ap1_2.result
cg_annotate out_3.out --auto=yes &> ../results/ejer1/ap1_3.result
cp out_1.out ../results/ejer1/ap1_1.out_valgrind
cp out_2.out ../results/ejer1/ap1_2.out_valgrind
cp out_3.out ../results/ejer1/ap1_3.out_valgrind

echo "Observe los resultados obtenidos e inspeccione el código con la herramienta cg_annotate. Anote
los resultados globales y observe los resultados prestando especial atención a las líneas 6 y 9 (ficheros annotate_*)"
rm -rf ./loop_merge.dSYM
rm -rf loop_merge
rm -rf loop_merge.cpp
rm -rf ./cachegrind.out.*
rm -rf ./annotate_*
rm -rf ./out_*