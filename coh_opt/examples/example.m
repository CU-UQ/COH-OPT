delete(gcp('nocreate'))
pool_data = parpool; % Key parts of code are paralellized
% Evaluation Related Options
eval_opt.qoi_handle = @zero_eval; % Doesn't evaluate QoI, left to user
eval_opt.grad = false; % gradient methods not implemented
eval_opt.max_dim = 10; % Maximum dimension of problem
eval_opt.grad_dim = 0; % Number of dimensions with gradients. (must correspond to first dimensions used)
eval_opt.p_type = repmat('l',1,eval_opt.max_dim);  % Type of polynomial 'l' here means legendre in each dimension. Also used to determine random variables used.
eval_opt.parallel_qoi_eval = false; % Evaluates multiple QoI at one time Useful when QoI Eval is expensive.

% Basis Related Options
basis_opt.type_handle = @basis_total_order; % Initial basis is total order
basis_opt.dim = eval_opt.max_dim; % Number of initial dimensions. Here, we use all dimensions.
basis_opt.ord = 2; % Initial total order of approximation. Here two.
basis_opt.pc_flag = false; % Whether or not to identify preconditioner. This option is useful for research if you define such a preconditioner.

% Options for generating a candidate sample set
sample_opt.sr = 0; % Can maintain a ratio of samples to basis functions if wanted, rarely useful for l1
sample_opt.initial_size = 20; % Initial size of sample.
sample_opt.n_workers = pool_data.NumWorkers; % Number of parallel workers from pool to use for sampling.
% These determine what distribution samples are drawn from
sample_opt.w_handle = @l2_w; % Minimize l2-coherence, linf_w would minimize the l1 style coherence
sample_opt.prop_handle = @orth_prop; % input proposals are from orthogonality measure
% These are for quality of MCMC sampler distribution matching target
sample_opt.burn_in = 500; % Number of burn-in samples
sample_opt.log_col_rate = -32; % Logarithm of collision rate (MCMC samples to be discarded)


basis = basis_init(basis_opt, eval_opt); % Identifies basis.
fprintf('Basis Initialized\n');
sample = sample_init(basis, sample_opt, eval_opt); % Computes Sample
fprintf('Sample Initialized\n');

