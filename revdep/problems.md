# blavaan

<details>

* Version: 0.3-9
* Source code: https://github.com/cran/blavaan
* Date/Publication: 2020-03-09 17:20:02 UTC
* Number of recursive dependencies: 102

Run `revdep_details(,"blavaan")` for more info

</details>

## In both

*   checking whether package ‘blavaan’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/wynton/home/cbi/hb/repositories/future.apply/revdep/checks/blavaan/new/blavaan.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘blavaan’ ...
** package ‘blavaan’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
"/wynton/home/cbi/shared/software/CBI/R-3.6.3/lib64/R/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/stanmarg.stan
.Rprofile error [/wynton/home/cbi/hb/repositories/future.apply/revdep/checks/blavaan/new/blavaan.Rcheck/00_pkg_src/blavaan/src: /wynton/home/cbi/shared/software/CBI/R-3.6.3/lib64/R/bin/exec/R --slave --no-restore -e source(file.path('..',~+~'tools',~+~'make_cc.R'));~+~make_cc(commandArgs(TRUE)) --args stan_files/stanmarg.stan]: there is no package called ‘startup’
Wrote C++ file "stan_files/stanmarg.cc"
g++ -std=c++1y -fPIC  -I"/wynton/home/cbi/shared/software/CBI/R-3.6.3/lib64/R/include" -DNDEBUG -I"../inst/include" -I"`"/wynton/home/cbi/shared/software/CBI/R-3.6.3/lib64/R/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_RESULT_OF_USE_TR1 -DBOOST_NO_DECLTYPE -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I"/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include" -I"/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include" -I"/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include" -I"/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/Rcpp/include" -I"/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/RcppEigen/include" -I/usr/local/include    -Wno-unused-variable -Wno-unused-function -c stan_files/stanmarg.cc -o stan_files/stanmarg.o
In file included from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/fun/ordered_constrain.hpp:6:0,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat.hpp:41,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/model/test_gradients.hpp:7,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include/rstan/stan_fit.hpp:35,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include/rstan/rstaninc.hpp:3,
                 from stan_files/stanmarg.hpp:18,
                 from stan_files/stanmarg.cc:3:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:31:32: error: ‘std::index_sequence’ has not been declared
                           std::index_sequence<I...> i) {
                                ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:31:46: error: expected ‘,’ or ‘...’ before ‘<’ token
                           std::index_sequence<I...> i) {
                                              ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp: In function ‘constexpr auto stan::math::internal::apply(const F&, const Tuple&)’:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:49:27: error: ‘make_index_sequence’ is not a member of ‘std’
   return apply_impl(f, t, std::make_index_sequence<std::tuple_size<Tuple>{}>{});
                           ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:49:27: note: suggested alternative:
In file included from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/container/vector/vector.hpp:28:0,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/container/vector/vector10.hpp:25,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/view/transform_view/transform_view.hpp:22,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/algorithm/transformation/transform.hpp:11,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/view/zip_view/detail/begin_impl.hpp:14,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/view/zip_view/zip_view.hpp:16,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/view/zip_view.hpp:12,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/include/zip_view.hpp:11,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/numeric/odeint/util/resize.hpp:26,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/numeric/odeint/util/state_wrapper.hpp:26,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/numeric/odeint/util/ublas_wrapper.hpp:33,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/numeric/odeint.hpp:25,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/prim/arr/functor/integrate_ode_rk45.hpp:17,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/prim/arr.hpp:46,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/prim/mat.hpp:344,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat.hpp:12,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/model/test_gradients.hpp:7,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include/rstan/stan_fit.hpp:35,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include/rstan/rstaninc.hpp:3,
                 from stan_files/stanmarg.hpp:18,
                 from stan_files/stanmarg.cc:3:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/support/detail/index_sequence.hpp:59:12: note:   ‘boost::fusion::detail::make_index_sequence’
     struct make_index_sequence
            ^
In file included from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/fun/ordered_constrain.hpp:6:0,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat.hpp:41,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/model/test_gradients.hpp:7,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include/rstan/stan_fit.hpp:35,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include/rstan/rstaninc.hpp:3,
                 from stan_files/stanmarg.hpp:18,
                 from stan_files/stanmarg.cc:3:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:49:77: error: expected primary-expression before ‘{’ token
   return apply_impl(f, t, std::make_index_sequence<std::tuple_size<Tuple>{}>{});
                                                                             ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:49:77: error: expected ‘)’ before ‘{’ token
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp: At global scope:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:151:9: error: expected type-specifier
       = std::result_of_t<F(decltype(is_var_), decltype(value_of(Targs()))...)>;
         ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:156:42: error: ‘FReturnType’ was not declared in this scope
   std::array<int, internal::compute_dims<FReturnType>::value> M_;
                                          ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:156:53: error: template argument 1 is invalid
   std::array<int, internal::compute_dims<FReturnType>::value> M_;
                                                     ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:156:61: error: template argument 2 is invalid
   std::array<int, internal::compute_dims<FReturnType>::value> M_;
                                                             ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp: In member function ‘std::vector<stan::math::var> stan::math::adj_jac_vari<F, Targs>::build_return_varis_and_vars(const std::vector<double>&)’:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:349:9: error: invalid types ‘int[int]’ for array subscript
     M_[0] = val_y.size();
         ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:350:32: error: invalid types ‘int[int]’ for array subscript
     std::vector<var> var_y(M_[0]);
                                ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp: In member function ‘Eigen::Matrix<stan::math::var, R, C> stan::math::adj_jac_vari<F, Targs>::build_return_varis_and_vars(const Eigen::Matrix<double, R, C>&)’:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:375:9: error: invalid types ‘int[int]’ for array subscript
     M_[0] = val_y.rows();
         ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:376:9: error: invalid types ‘int[int]’ for array subscript
     M_[1] = val_y.cols();
         ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:377:40: error: invalid types ‘int[int]’ for array subscript
     Eigen::Matrix<var, R, C> var_y(M_[0], M_[1]);
                                        ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:377:47: error: invalid types ‘int[int]’ for array subscript
     Eigen::Matrix<var, R, C> var_y(M_[0], M_[1]);
                                               ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp: In member function ‘void stan::math::adj_jac_vari<F, Targs>::chain()’:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:530:5: error: ‘FReturnType’ was not declared in this scope
     FReturnType y_adj;
     ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:530:17: error: expected ‘;’ before ‘y_adj’
     FReturnType y_adj;
                 ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:532:38: error: ‘y_adj’ was not declared in this scope
     internal::build_y_adj(y_vi_, M_, y_adj);
                                      ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:536:26: error: expansion pattern ‘auto&&’ contains no argument packs
         [this](auto&&... args) { this->accumulate_adjoints(args...); },
                          ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp: In lambda function:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:536:60: error: ‘args’ was not declared in this scope
         [this](auto&&... args) { this->accumulate_adjoints(args...); },
                                                            ^
make: *** [stan_files/stanmarg.o] Error 1
rm stan_files/stanmarg.cc
ERROR: compilation failed for package ‘blavaan’
* removing ‘/wynton/home/cbi/hb/repositories/future.apply/revdep/checks/blavaan/new/blavaan.Rcheck/blavaan’

```
### CRAN

```
* installing *source* package ‘blavaan’ ...
** package ‘blavaan’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
"/wynton/home/cbi/shared/software/CBI/R-3.6.3/lib64/R/bin/Rscript" -e "source(file.path('..', 'tools', 'make_cc.R')); make_cc(commandArgs(TRUE))" stan_files/stanmarg.stan
.Rprofile error [/wynton/home/cbi/hb/repositories/future.apply/revdep/checks/blavaan/old/blavaan.Rcheck/00_pkg_src/blavaan/src: /wynton/home/cbi/shared/software/CBI/R-3.6.3/lib64/R/bin/exec/R --slave --no-restore -e source(file.path('..',~+~'tools',~+~'make_cc.R'));~+~make_cc(commandArgs(TRUE)) --args stan_files/stanmarg.stan]: there is no package called ‘startup’
Wrote C++ file "stan_files/stanmarg.cc"
g++ -std=c++1y -fPIC  -I"/wynton/home/cbi/shared/software/CBI/R-3.6.3/lib64/R/include" -DNDEBUG -I"../inst/include" -I"`"/wynton/home/cbi/shared/software/CBI/R-3.6.3/lib64/R/bin/Rscript" --vanilla -e "cat(system.file('include', 'src', package = 'StanHeaders'))"`" -DBOOST_RESULT_OF_USE_TR1 -DBOOST_NO_DECLTYPE -DBOOST_DISABLE_ASSERTS -DEIGEN_NO_DEBUG -DBOOST_MATH_OVERFLOW_ERROR_POLICY=errno_on_error -I"/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include" -I"/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include" -I"/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include" -I"/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/Rcpp/include" -I"/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/RcppEigen/include" -I/usr/local/include    -Wno-unused-variable -Wno-unused-function -c stan_files/stanmarg.cc -o stan_files/stanmarg.o
In file included from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/fun/ordered_constrain.hpp:6:0,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat.hpp:41,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/model/test_gradients.hpp:7,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include/rstan/stan_fit.hpp:35,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include/rstan/rstaninc.hpp:3,
                 from stan_files/stanmarg.hpp:18,
                 from stan_files/stanmarg.cc:3:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:31:32: error: ‘std::index_sequence’ has not been declared
                           std::index_sequence<I...> i) {
                                ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:31:46: error: expected ‘,’ or ‘...’ before ‘<’ token
                           std::index_sequence<I...> i) {
                                              ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp: In function ‘constexpr auto stan::math::internal::apply(const F&, const Tuple&)’:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:49:27: error: ‘make_index_sequence’ is not a member of ‘std’
   return apply_impl(f, t, std::make_index_sequence<std::tuple_size<Tuple>{}>{});
                           ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:49:27: note: suggested alternative:
In file included from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/container/vector/vector.hpp:28:0,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/container/vector/vector10.hpp:25,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/view/transform_view/transform_view.hpp:22,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/algorithm/transformation/transform.hpp:11,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/view/zip_view/detail/begin_impl.hpp:14,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/view/zip_view/zip_view.hpp:16,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/view/zip_view.hpp:12,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/include/zip_view.hpp:11,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/numeric/odeint/util/resize.hpp:26,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/numeric/odeint/util/state_wrapper.hpp:26,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/numeric/odeint/util/ublas_wrapper.hpp:33,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/numeric/odeint.hpp:25,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/prim/arr/functor/integrate_ode_rk45.hpp:17,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/prim/arr.hpp:46,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/prim/mat.hpp:344,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat.hpp:12,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/model/test_gradients.hpp:7,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include/rstan/stan_fit.hpp:35,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include/rstan/rstaninc.hpp:3,
                 from stan_files/stanmarg.hpp:18,
                 from stan_files/stanmarg.cc:3:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/BH/include/boost/fusion/support/detail/index_sequence.hpp:59:12: note:   ‘boost::fusion::detail::make_index_sequence’
     struct make_index_sequence
            ^
In file included from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/fun/ordered_constrain.hpp:6:0,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat.hpp:41,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/model/log_prob_grad.hpp:4,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/model/test_gradients.hpp:7,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/src/stan/services/diagnose/diagnose.hpp:10,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include/rstan/stan_fit.hpp:35,
                 from /wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/rstan/include/rstan/rstaninc.hpp:3,
                 from stan_files/stanmarg.hpp:18,
                 from stan_files/stanmarg.cc:3:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:49:77: error: expected primary-expression before ‘{’ token
   return apply_impl(f, t, std::make_index_sequence<std::tuple_size<Tuple>{}>{});
                                                                             ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:49:77: error: expected ‘)’ before ‘{’ token
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp: At global scope:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:151:9: error: expected type-specifier
       = std::result_of_t<F(decltype(is_var_), decltype(value_of(Targs()))...)>;
         ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:156:42: error: ‘FReturnType’ was not declared in this scope
   std::array<int, internal::compute_dims<FReturnType>::value> M_;
                                          ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:156:53: error: template argument 1 is invalid
   std::array<int, internal::compute_dims<FReturnType>::value> M_;
                                                     ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:156:61: error: template argument 2 is invalid
   std::array<int, internal::compute_dims<FReturnType>::value> M_;
                                                             ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp: In member function ‘std::vector<stan::math::var> stan::math::adj_jac_vari<F, Targs>::build_return_varis_and_vars(const std::vector<double>&)’:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:349:9: error: invalid types ‘int[int]’ for array subscript
     M_[0] = val_y.size();
         ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:350:32: error: invalid types ‘int[int]’ for array subscript
     std::vector<var> var_y(M_[0]);
                                ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp: In member function ‘Eigen::Matrix<stan::math::var, R, C> stan::math::adj_jac_vari<F, Targs>::build_return_varis_and_vars(const Eigen::Matrix<double, R, C>&)’:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:375:9: error: invalid types ‘int[int]’ for array subscript
     M_[0] = val_y.rows();
         ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:376:9: error: invalid types ‘int[int]’ for array subscript
     M_[1] = val_y.cols();
         ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:377:40: error: invalid types ‘int[int]’ for array subscript
     Eigen::Matrix<var, R, C> var_y(M_[0], M_[1]);
                                        ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:377:47: error: invalid types ‘int[int]’ for array subscript
     Eigen::Matrix<var, R, C> var_y(M_[0], M_[1]);
                                               ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp: In member function ‘void stan::math::adj_jac_vari<F, Targs>::chain()’:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:530:5: error: ‘FReturnType’ was not declared in this scope
     FReturnType y_adj;
     ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:530:17: error: expected ‘;’ before ‘y_adj’
     FReturnType y_adj;
                 ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:532:38: error: ‘y_adj’ was not declared in this scope
     internal::build_y_adj(y_vi_, M_, y_adj);
                                      ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:536:26: error: expansion pattern ‘auto&&’ contains no argument packs
         [this](auto&&... args) { this->accumulate_adjoints(args...); },
                          ^
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp: In lambda function:
/wynton/home/cbi/hb/repositories/future.apply/revdep/library/blavaan/StanHeaders/include/stan/math/rev/mat/functor/adj_jac_apply.hpp:536:60: error: ‘args’ was not declared in this scope
         [this](auto&&... args) { this->accumulate_adjoints(args...); },
                                                            ^
make: *** [stan_files/stanmarg.o] Error 1
rm stan_files/stanmarg.cc
ERROR: compilation failed for package ‘blavaan’
* removing ‘/wynton/home/cbi/hb/repositories/future.apply/revdep/checks/blavaan/old/blavaan.Rcheck/blavaan’

```
# blockCV

<details>

* Version: 2.1.1
* Source code: https://github.com/cran/blockCV
* URL: https://github.com/rvalavi/blockCV
* Date/Publication: 2020-02-23 20:00:02 UTC
* Number of recursive dependencies: 104

Run `revdep_details(,"blockCV")` for more info

</details>

## In both

*   checking tests ...
    ```
    ...
       12. layout$setup_panel_params()
       13. ggplot2:::f(..., self = self)
       14. base::Map(setup_panel_params, scales_x, scales_y)
       15. base::mapply(FUN = f, ..., SIMPLIFY = FALSE)
       17. self$coord$setup_panel_params(scale_x, scale_y, params = self$coord_params)
       18. ggplot2:::f(..., self = self)
       19. sf::st_graticule(...)
       21. sf:::st_transform.sfc(box, datum, partial = TRUE)
       23. sf:::CPL_transform(x, crs, aoi, pipeline, reverse)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 127 | SKIPPED: 8 | WARNINGS: 7 | FAILED: 6 ]
      1. Error: test spatialAutoRange function with multi-layer raster in parallel (@testSpatialAutoRange.R#19) 
      2. Error: test spatialAutoRange for low-resolution rasters (@testSpatialAutoRange.R#71) 
      3. Error: test spatiaBlock function with systematic assingment and no raster file (@testSpatialBlock.R#65) 
      4. Error: test spatiaBlock function with non-numeric iteration (@testSpatialBlock.R#98) 
      5. Error: test spatiaBlock with checkerboard assingment and only row blocks (@testSpatialBlock.R#132) 
      6. Error: test spatialBlock with no speceis column match (@testSpatialBlock.R#269) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking Rd cross-references ... NOTE
    ```
    Unknown package ‘biomod2’ in Rd xrefs
    ```

# cSEM

<details>

* Version: 0.2.0
* Source code: https://github.com/cran/cSEM
* URL: https://github.com/M-E-Rademaker/cSEM, https://m-e-rademaker.github.io/cSEM/
* BugReports: https://github.com/M-E-Rademaker/cSEM/issues
* Date/Publication: 2020-03-29 11:00:20 UTC
* Number of recursive dependencies: 110

Run `revdep_details(,"cSEM")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘Rdpack’
      All declared Imports should be used.
    ```

# DeclareDesign

<details>

* Version: 0.22.0
* Source code: https://github.com/cran/DeclareDesign
* URL: https://declaredesign.org, https://github.com/DeclareDesign/DeclareDesign
* BugReports: https://github.com/DeclareDesign/DeclareDesign/issues
* Date/Publication: 2020-03-24 07:40:10 UTC
* Number of recursive dependencies: 132

Run `revdep_details(,"DeclareDesign")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘sf’
    ```

# fabletools

<details>

* Version: 0.1.3
* Source code: https://github.com/cran/fabletools
* URL: http://fabletools.tidyverts.org/, https://github.com/tidyverts/fabletools
* BugReports: https://github.com/tidyverts/fabletools/issues
* Date/Publication: 2020-03-24 07:10:02 UTC
* Number of recursive dependencies: 92

Run `revdep_details(,"fabletools")` for more info

</details>

## In both

*   checking S3 generic/method consistency ... WARNING
    ```
    Failed to query server: Connection timed out
    See section ‘Generic functions and methods’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking replacement functions ... WARNING
    ```
    Failed to query server: Connection timed out
    The argument of a replacement function which corresponds to the right
    hand side must be named ‘value’.
    ```

*   checking Rd files ... WARNING
    ```
    Failed to query server: Connection timed out
    prepare_Rd: running command 'timedatectl' had status 1
    ```

*   checking for missing documentation entries ... WARNING
    ```
    Failed to query server: Connection timed out
    All user-level objects in a package should have documentation entries.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking for code/documentation mismatches ... WARNING
    ```
    Failed to query server: Connection timed out
    Failed to query server: Connection timed out
    Failed to query server: Connection timed out
    ```

*   checking for unstated dependencies in examples ... WARNING
    ```
    Failed to query server: Connection timed out
    Warning in system("timedatectl", intern = TRUE) :
      running command 'timedatectl' had status 1
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘feasts’
    ```

*   checking dependencies in R code ... NOTE
    ```
    Failed to query server: Connection timed out
    ```

*   checking foreign function calls ... NOTE
    ```
    Failed to query server: Connection timed out
    See chapter ‘System and foreign language interfaces’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking R code for possible problems ... NOTE
    ```
    Failed to query server: Connection timed out
    ```

*   checking Rd \usage sections ... NOTE
    ```
    Failed to query server: Connection timed out
    The \usage entries for S3 methods should use the \method markup and not
    their full name.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

# forecastML

<details>

* Version: 0.8.0
* Source code: https://github.com/cran/forecastML
* URL: https://github.com/nredell/forecastML/
* Date/Publication: 2020-02-28 22:40:12 UTC
* Number of recursive dependencies: 92

Run `revdep_details(,"forecastML")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘xgboost’
    ```

# future.batchtools

<details>

* Version: 0.8.1
* Source code: https://github.com/cran/future.batchtools
* URL: https://github.com/HenrikBengtsson/future.batchtools
* BugReports: https://github.com/HenrikBengtsson/future.batchtools/issues
* Date/Publication: 2019-10-01 05:10:05 UTC
* Number of recursive dependencies: 34

Run `revdep_details(,"future.batchtools")` for more info

</details>

## In both

*   R CMD check timed out
    

# grattan

<details>

* Version: 1.8.0.1
* Source code: https://github.com/cran/grattan
* URL: https://github.com/HughParsonage/grattan, https://hughparsonage.github.io/grattan/
* BugReports: https://github.com/HughParsonage/grattan/issues
* Date/Publication: 2020-03-16 16:40:09 UTC
* Number of recursive dependencies: 113

Run `revdep_details(,"grattan")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      'taxstats', 'taxstats1516'
    ```

# GSODR

<details>

* Version: 2.0.1
* Source code: https://github.com/cran/GSODR
* URL: https://docs.ropensci.org/GSODR/
* BugReports: https://github.com/ropensci/GSODR/issues
* Date/Publication: 2020-01-24 07:50:02 UTC
* Number of recursive dependencies: 122

Run `revdep_details(,"GSODR")` for more info

</details>

## In both

*   checking tests ...
    ```
    ...
       11. value[[3L]](cond)
      
      ── 2. Error: when year is selected for a station not providing it, error (@test-
      
      The file downloads have failed. Please restart.
      Backtrace:
        1. testthat::expect_message(...)
        6. GSODR::get_GSOD(years = 1950, station = "959360-99999")
        7. GSODR:::.download_files(station, years)
        8. base::tryCatch(...)
        9. base:::tryCatchList(expr, classes, parentenv, handlers)
       10. base:::tryCatchOne(expr, names, parentenv, handlers[[1L]])
       11. value[[3L]](cond)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 31 | SKIPPED: 9 | WARNINGS: 0 | FAILED: 2 ]
      1. Failure: The 'max_missing' parameter filters out improper stations (@test-get_GSOD.R#128) 
      2. Error: when year is selected for a station not providing it, error (@test-get_GSOD.R#249) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# gstat

<details>

* Version: 2.0-5
* Source code: https://github.com/cran/gstat
* URL: https://github.com/r-spatial/gstat/
* BugReports: https://github.com/r-spatial/gstat/issues/
* Date/Publication: 2020-04-04 14:20:02 UTC
* Number of recursive dependencies: 37

Run `revdep_details(,"gstat")` for more info

</details>

## In both

*   checking tests ...
    ```
    ...
      
      > meuse.riv <- SpatialPolygons(list(Polygons(list(Polygon(meuse.riv)),"meuse.riv")))
      
      > proj4string(meuse.riv) <- crs
      
      > data("meuse.area")
      
      > meuse.area = SpatialPolygons(list(Polygons(list(Polygon(meuse.area)), "area")))
      
      > proj4string(meuse.area) <- crs
      > 
      > v = variogram(log(zinc)~1, meuse_sf)
      > (v.fit = fit.variogram(v, vgm(1, "Sph", 900, 1)))
        model      psill    range
      1   Nug 0.05066243   0.0000
      2   Sph 0.59060780 897.0209
      > k_sf = krige(log(zinc)~1, meuse_sf[-(1:5),], meuse_sf[1:5,], v.fit)
      Error in .local(formula, locations, ...) : 
        stars required: install that first
      Calls: krige -> krige -> .local
      Execution halted
    ```

# gWQS

<details>

* Version: 2.0.1
* Source code: https://github.com/cran/gWQS
* Date/Publication: 2020-03-03 12:20:02 UTC
* Number of recursive dependencies: 159

Run `revdep_details(,"gWQS")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘dplyr’
      All declared Imports should be used.
    ```

# gWQSRS

<details>

* Version: 1.1.1
* Source code: https://github.com/cran/gWQSRS
* Date/Publication: 2020-03-03 11:40:02 UTC
* Number of recursive dependencies: 111

Run `revdep_details(,"gWQSRS")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘broom’ ‘dplyr’ ‘ggrepel’ ‘kableExtra’ ‘knitr’ ‘nnet’ ‘plotROC’
      All declared Imports should be used.
    ```

# hackeRnews

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/hackeRnews
* URL: https://github.com/szymanskir/hackeRnews
* BugReports: https://github.com/szymanskir/hackeRnews/issues
* Date/Publication: 2019-12-13 13:20:05 UTC
* Number of recursive dependencies: 62

Run `revdep_details(,"hackeRnews")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘hackeRnews-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: get_best_stories
    > ### Title: Hacker News best stories
    > ### Aliases: get_best_stories
    > 
    > ### ** Examples
    > 
    > # get the best story on Hacker News
    > best_story <- get_best_stories(max_items = 1)
    Error in curl::curl_fetch_memory(url, handle = handle) : 
      Could not resolve host: hacker-news.firebaseio.com; Name or service not known
    Calls: get_best_stories ... request_fetch -> request_fetch.write_memory -> <Anonymous>
    Execution halted
    ```

# iml

<details>

* Version: 0.10.0
* Source code: https://github.com/cran/iml
* URL: https://github.com/christophM/iml
* BugReports: https://github.com/christophM/iml/issues
* Date/Publication: 2020-03-26 10:20:03 UTC
* Number of recursive dependencies: 155

Run `revdep_details(,"iml")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘future’
      All declared Imports should be used.
    ```

# inlinedocs

<details>

* Version: 2019.12.5
* Source code: https://github.com/cran/inlinedocs
* URL: http://github.com/tdhock/inlinedocs
* BugReports: http://github.com/tdhock/inlinedocs/issues
* Date/Publication: 2019-12-05 23:30:07 UTC
* Number of recursive dependencies: 6

Run `revdep_details(,"inlinedocs")` for more info

</details>

## In both

*   checking Rd cross-references ... NOTE
    ```
    Unknown package ‘R.methodsS3’ in Rd xrefs
    ```

# mcp

<details>

* Version: 0.2.0
* Source code: https://github.com/cran/mcp
* URL: http://lindeloev.github.io/mcp/, https://github.com/lindeloev/mcp
* BugReports: https://github.com/lindeloev/mcp/issues
* Date/Publication: 2020-01-09 16:30:02 UTC
* Number of recursive dependencies: 94

Run `revdep_details(,"mcp")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘bayesplot’ ‘methods’ ‘purrr’
      All declared Imports should be used.
    ```

# merTools

<details>

* Version: 0.5.0
* Source code: https://github.com/cran/merTools
* BugReports: https://www.github.com/jknowles/merTools
* Date/Publication: 2019-05-13 12:30:06 UTC
* Number of recursive dependencies: 130

Run `revdep_details(,"merTools")` for more info

</details>

## In both

*   checking whether the namespace can be loaded with stated dependencies ... WARNING
    ```
    Error in setClass("balance", representation(rawdata = "data.frame", matched = "data.frame",  : 
      could not find function "setClass"
    Error: unable to load R code in package ‘arm’
    Execution halted
    
    A namespace must be able to be loaded with just the base namespace
    loaded: otherwise if the namespace gets loaded by a saved object, the
    session will be unable to start.
    
    Probably some imports need to be declared in the NAMESPACE file.
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘rstanarm’
    ```

*   checking R code for possible problems ... NOTE
    ```
    Error in setClass("balance", representation(rawdata = "data.frame", matched = "data.frame",  : 
      could not find function "setClass"
    Error: unable to load R code in package ‘arm’
    Execution halted
    ```

# origami

<details>

* Version: 1.0.3
* Source code: https://github.com/cran/origami
* URL: https://tlverse.org/origami
* BugReports: https://github.com/tlverse/origami/issues
* Date/Publication: 2020-01-16 22:40:02 UTC
* Number of recursive dependencies: 82

Run `revdep_details(,"origami")` for more info

</details>

## In both

*   checking Rd cross-references ... NOTE
    ```
    Unknown package ‘glmnet’ in Rd xrefs
    ```

# phylolm

<details>

* Version: 2.6
* Source code: https://github.com/cran/phylolm
* URL: https://CRAN.R-project.org/package=phylolm
* Date/Publication: 2018-05-31 04:51:24 UTC
* Number of recursive dependencies: 33

Run `revdep_details(,"phylolm")` for more info

</details>

## In both

*   checking Rd cross-references ... NOTE
    ```
    Unknown packages ‘surface’, ‘bayou’, ‘geiger’, ‘caper’ in Rd xrefs
    ```

# prewas

<details>

* Version: 1.1.0
* Source code: https://github.com/cran/prewas
* URL: http://github.com/Snitkin-Lab-Umich/prewas
* BugReports: http://github.com/Snitkin-Lab-Umich/prewas/issues
* Date/Publication: 2020-03-21 17:10:06 UTC
* Number of recursive dependencies: 71

Run `revdep_details(,"prewas")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘stats’
      All declared Imports should be used.
    ```

# QDNAseq

<details>

* Version: 1.22.0
* Source code: https://github.com/cran/QDNAseq
* URL: https://github.com/ccagc/QDNAseq
* BugReports: https://github.com/ccagc/QDNAseq/issues
* Date/Publication: 2019-10-29
* Number of recursive dependencies: 70

Run `revdep_details(,"QDNAseq")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘future’
      All declared Imports should be used.
    ```

# qgcomp

<details>

* Version: 2.2.2
* Source code: https://github.com/cran/qgcomp
* Date/Publication: 2020-03-01 23:00:02 UTC
* Number of recursive dependencies: 81

Run `revdep_details(,"qgcomp")` for more info

</details>

## In both

*   checking for missing documentation entries ... ERROR
    ```
    ...
    Call sequence:
    6: stop(msg, call. = FALSE, domain = NA)
    5: value[[3L]](cond)
    4: tryCatchOne(expr, names, parentenv, handlers[[1L]])
    3: tryCatchList(expr, classes, parentenv, handlers)
    2: tryCatch({
           attr(package, "LibPath") <- which.lib.loc
           ns <- loadNamespace(package, lib.loc)
           env <- attachNamespace(ns, pos = pos, deps, exclude, include.only)
       }, error = function(e) {
           P <- if (!is.null(cc <- conditionCall(e))) 
               paste(" in", deparse(cc)[1L])
           else ""
           msg <- gettextf("package or namespace load failed for %s%s:\n %s", 
               sQuote(package), P, conditionMessage(e))
           if (logical.return) 
               message(paste("Error:", msg), domain = NA)
           else stop(msg, call. = FALSE, domain = NA)
       })
    1: library(package, lib.loc = lib.loc, character.only = TRUE, verbose = FALSE)
    Execution halted
    ```

*   checking whether the package can be unloaded cleanly ... WARNING
    ```
    Error in setClass("balance", representation(rawdata = "data.frame", matched = "data.frame",  : 
      could not find function "setClass"
    Error: package or namespace load failed for ‘qgcomp’:
     unable to load R code in package ‘arm’
    Execution halted
    ```

*   checking whether the namespace can be loaded with stated dependencies ... WARNING
    ```
    Error in setClass("balance", representation(rawdata = "data.frame", matched = "data.frame",  : 
      could not find function "setClass"
    Error: unable to load R code in package ‘arm’
    Execution halted
    
    A namespace must be able to be loaded with just the base namespace
    loaded: otherwise if the namespace gets loaded by a saved object, the
    session will be unable to start.
    
    Probably some imports need to be declared in the NAMESPACE file.
    ```

*   checking S3 generic/method consistency ... WARNING
    ```
    ...
    5: value[[3L]](cond)
    4: tryCatchOne(expr, names, parentenv, handlers[[1L]])
    3: tryCatchList(expr, classes, parentenv, handlers)
    2: tryCatch({
           attr(package, "LibPath") <- which.lib.loc
           ns <- loadNamespace(package, lib.loc)
           env <- attachNamespace(ns, pos = pos, deps, exclude, include.only)
       }, error = function(e) {
           P <- if (!is.null(cc <- conditionCall(e))) 
               paste(" in", deparse(cc)[1L])
           else ""
           msg <- gettextf("package or namespace load failed for %s%s:\n %s", 
               sQuote(package), P, conditionMessage(e))
           if (logical.return) 
               message(paste("Error:", msg), domain = NA)
           else stop(msg, call. = FALSE, domain = NA)
       })
    1: library(package, lib.loc = lib.loc, character.only = TRUE, verbose = FALSE)
    Execution halted
    See section ‘Generic functions and methods’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking replacement functions ... WARNING
    ```
    ...
    5: value[[3L]](cond)
    4: tryCatchOne(expr, names, parentenv, handlers[[1L]])
    3: tryCatchList(expr, classes, parentenv, handlers)
    2: tryCatch({
           attr(package, "LibPath") <- which.lib.loc
           ns <- loadNamespace(package, lib.loc)
           env <- attachNamespace(ns, pos = pos, deps, exclude, include.only)
       }, error = function(e) {
           P <- if (!is.null(cc <- conditionCall(e))) 
               paste(" in", deparse(cc)[1L])
           else ""
           msg <- gettextf("package or namespace load failed for %s%s:\n %s", 
               sQuote(package), P, conditionMessage(e))
           if (logical.return) 
               message(paste("Error:", msg), domain = NA)
           else stop(msg, call. = FALSE, domain = NA)
       })
    1: library(package, lib.loc = lib.loc, character.only = TRUE, verbose = FALSE)
    Execution halted
    The argument of a replacement function which corresponds to the right
    hand side must be named ‘value’.
    ```

*   checking for code/documentation mismatches ... WARNING
    ```
    ...
    Call sequence:
    6: stop(msg, call. = FALSE, domain = NA)
    5: value[[3L]](cond)
    4: tryCatchOne(expr, names, parentenv, handlers[[1L]])
    3: tryCatchList(expr, classes, parentenv, handlers)
    2: tryCatch({
           attr(package, "LibPath") <- which.lib.loc
           ns <- loadNamespace(package, lib.loc)
           env <- attachNamespace(ns, pos = pos, deps, exclude, include.only)
       }, error = function(e) {
           P <- if (!is.null(cc <- conditionCall(e))) 
               paste(" in", deparse(cc)[1L])
           else ""
           msg <- gettextf("package or namespace load failed for %s%s:\n %s", 
               sQuote(package), P, conditionMessage(e))
           if (logical.return) 
               message(paste("Error:", msg), domain = NA)
           else stop(msg, call. = FALSE, domain = NA)
       })
    1: library(package, lib.loc = lib.loc, character.only = TRUE, verbose = FALSE)
    Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    ...
    Call sequence:
    6: stop(msg, call. = FALSE, domain = NA)
    5: value[[3L]](cond)
    4: tryCatchOne(expr, names, parentenv, handlers[[1L]])
    3: tryCatchList(expr, classes, parentenv, handlers)
    2: tryCatch({
           attr(package, "LibPath") <- which.lib.loc
           ns <- loadNamespace(package, lib.loc)
           env <- attachNamespace(ns, pos = pos, deps, exclude, include.only)
       }, error = function(e) {
           P <- if (!is.null(cc <- conditionCall(e))) 
               paste(" in", deparse(cc)[1L])
           else ""
           msg <- gettextf("package or namespace load failed for %s%s:\n %s", 
               sQuote(package), P, conditionMessage(e))
           if (logical.return) 
               message(paste("Error:", msg), domain = NA)
           else stop(msg, call. = FALSE, domain = NA)
       })
    1: library(package, lib.loc = lib.loc, character.only = TRUE, verbose = FALSE)
    Execution halted
    ```

*   checking foreign function calls ... NOTE
    ```
    ...
    5: value[[3L]](cond)
    4: tryCatchOne(expr, names, parentenv, handlers[[1L]])
    3: tryCatchList(expr, classes, parentenv, handlers)
    2: tryCatch({
           attr(package, "LibPath") <- which.lib.loc
           ns <- loadNamespace(package, lib.loc)
           env <- attachNamespace(ns, pos = pos, deps, exclude, include.only)
       }, error = function(e) {
           P <- if (!is.null(cc <- conditionCall(e))) 
               paste(" in", deparse(cc)[1L])
           else ""
           msg <- gettextf("package or namespace load failed for %s%s:\n %s", 
               sQuote(package), P, conditionMessage(e))
           if (logical.return) 
               message(paste("Error:", msg), domain = NA)
           else stop(msg, call. = FALSE, domain = NA)
       })
    1: library(package, lib.loc = lib.loc, character.only = TRUE, verbose = FALSE)
    Execution halted
    See chapter ‘System and foreign language interfaces’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking R code for possible problems ... NOTE
    ```
    Error in setClass("balance", representation(rawdata = "data.frame", matched = "data.frame",  : 
      could not find function "setClass"
    Error: unable to load R code in package ‘arm’
    Execution halted
    ```

*   checking Rd \usage sections ... NOTE
    ```
    ...
    3: tryCatchList(expr, classes, parentenv, handlers)
    2: tryCatch({
           attr(package, "LibPath") <- which.lib.loc
           ns <- loadNamespace(package, lib.loc)
           env <- attachNamespace(ns, pos = pos, deps, exclude, include.only)
       }, error = function(e) {
           P <- if (!is.null(cc <- conditionCall(e))) 
               paste(" in", deparse(cc)[1L])
           else ""
           msg <- gettextf("package or namespace load failed for %s%s:\n %s", 
               sQuote(package), P, conditionMessage(e))
           if (logical.return) 
               message(paste("Error:", msg), domain = NA)
           else stop(msg, call. = FALSE, domain = NA)
       })
    1: library(package, lib.loc = lib.loc, character.only = TRUE, verbose = FALSE)
    Execution halted
    The \usage entries for S3 methods should use the \method markup and not
    their full name.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

# robotstxt

<details>

* Version: 0.6.2
* Source code: https://github.com/cran/robotstxt
* URL: https://github.com/ropensci/robotstxt
* BugReports: https://github.com/ropensci/robotstxt/issues
* Date/Publication: 2018-07-18 21:30:03 UTC
* Number of recursive dependencies: 63

Run `revdep_details(,"robotstxt")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘future’
      All declared Imports should be used.
    ```

# Seurat

<details>

* Version: 3.1.4
* Source code: https://github.com/cran/Seurat
* URL: http://www.satijalab.org/seurat, https://github.com/satijalab/seurat
* BugReports: https://github.com/satijalab/seurat/issues
* Date/Publication: 2020-02-26 19:00:06 UTC
* Number of recursive dependencies: 219

Run `revdep_details(,"Seurat")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      'loomR', 'SDMTools', 'hdf5r'
    ```

*   checking Rd cross-references ... NOTE
    ```
    Unknown packages ‘SDMTools’, ‘loomR’ in Rd xrefs
    ```

# solitude

<details>

* Version: 0.2.1
* Source code: https://github.com/cran/solitude
* URL: https://github.com/talegari/solitude
* BugReports: https://github.com/talegari/solitude/issues
* Date/Publication: 2019-12-07 09:00:02 UTC
* Number of recursive dependencies: 38

Run `revdep_details(,"solitude")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘R6’
      All declared Imports should be used.
    ```

# stars

<details>

* Version: 0.4-0
* Source code: https://github.com/cran/stars
* URL: https://r-spatial.github.io/stars/, https://github.com/r-spatial/stars/
* BugReports: https://github.com/r-spatial/stars/issues/
* Date/Publication: 2019-10-10 13:00:02 UTC
* Number of recursive dependencies: 122

Run `revdep_details(,"stars")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘lwgeom’
    
    Package suggested but not available for checking: ‘starsdata’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# TSstudio

<details>

* Version: 0.1.6
* Source code: https://github.com/cran/TSstudio
* URL: https://github.com/RamiKrispin/TSstudio
* BugReports: https://github.com/RamiKrispin/TSstudio/issues
* Date/Publication: 2020-01-21 05:30:02 UTC
* Number of recursive dependencies: 135

Run `revdep_details(,"TSstudio")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Failed to query server: Connection timed out
    Namespace in Imports field not imported from: ‘forecastHybrid’
      All declared Imports should be used.
    ```

