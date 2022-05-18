import UIKit

class ViewController: UIViewController {
    private let animationHelper = AnimationHelper()
    private var pokemonViewModel = PokemonViewModel()
    private var pokemonNumber = 2
    private let totalPokemons = 1125
    
    private var containerViewFront = UIView()
    private var imageViewFront = UIImageView()
    private var containerViewBack = UIView()
    private var imageViewBack = UIImageView()
    
    private var hpLabelFront = UILabel()
    private var attackLabelFront = UILabel()
    private var defenceLabelFront = UILabel()
    private var hpFront = UILabel()
    private var attackFront = UILabel()
    private var defenceFront = UILabel()
    
    private var hpLabelBack = UILabel()
    private var attackLabelBack = UILabel()
    private var defenceLabelBack = UILabel()
    private var hpBack = UILabel()
    private var attackBack = UILabel()
    private var defenceBack = UILabel()
    
    private var pokemonNameFront = UILabel()
    private var pokemonNameBack = UILabel()
    
    private var reloadButton = UIImageView()
    
    private var loadingLabel = UILabel()
    
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []
    
    private var constraintActivated: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 172 / 255.0, green: 158 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        
        addViews()
        
        setupLayout()
        
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
        
        setupTapRecognizers()
        
        pokemonViewModel.fetchItems {
            self.initializeView()
        }
    }
    
    @objc func frontCardTapped(_ sender:UIButton){
        if(pokemonNumber != totalPokemons) {
            self.animationHelper.firstAnimation(frontView: containerViewFront, backView: containerViewBack) {
                let pokemon = self.pokemonViewModel.pokemonListWithDetails[self.pokemonNumber]
                if let hp = pokemon.detail.stats?[0].baseStat {
                    self.hpFront.text = String(hp)
                }
                if let attack = pokemon.detail.stats?[1].baseStat {
                    self.attackFront.text = String(attack)
                }
                if let defence = pokemon.detail.stats?[2].baseStat {
                    self.defenceFront.text = String(defence)
                }
                self.pokemonNameFront.text = pokemon.name
                if let imageString = pokemon.detail.sprites?.frontDefault {
                    if let imageUrl = URL(string: imageString) {
                        if let data = try? Data(contentsOf: imageUrl) {
                            if let image = UIImage(data: data) {
                                self.imageViewFront.image = image
                            }
                        }
                    }
                }
            }
            pokemonNumber += 1
        }
        
    }
    @objc func backCardTapped(_ sender:UIButton){
        if(pokemonNumber != totalPokemons) {
            self.animationHelper.secondAnimation(frontView: containerViewBack, backView: containerViewFront) {
                let pokemon = self.pokemonViewModel.pokemonListWithDetails[self.pokemonNumber]
                if let hp = pokemon.detail.stats?[0].baseStat {
                    self.hpBack.text = String(hp)
                }
                if let attack = pokemon.detail.stats?[1].baseStat {
                    self.attackBack.text = String(attack)
                }
                if let defence = pokemon.detail.stats?[2].baseStat {
                    self.defenceBack.text = String(defence)
                }
                self.pokemonNameBack.text = pokemon.name
                if let imageString = pokemon.detail.sprites?.frontDefault {
                    if let imageUrl = URL(string: imageString) {
                        if let data = try? Data(contentsOf: imageUrl) {
                            if let image = UIImage(data: data) {
                                self.imageViewBack.image = image
                            }
                        }
                    }
                }
            }
            pokemonNumber += 1
        }
    }
    @objc func reloadTapped(_ sender: UIButton) {
        pokemonNumber = 2
        self.initializeView()
        
    }
    private func initializeView() {
        hpLabelFront.text = "hp"
        attackLabelFront.text = "attack"
        defenceLabelFront.text = "defence"
        hpLabelBack.text = "hp"
        attackLabelBack.text = "attack"
        defenceLabelBack.text = "defence"
        loadingLabel.text = ""
        
        containerViewBack.isHidden = true
        containerViewFront.isHidden = false
        
        containerViewFront.isUserInteractionEnabled = true
        containerViewBack.isUserInteractionEnabled = true
        reloadButton.isUserInteractionEnabled = true
        
        let pokemon = self.pokemonViewModel.pokemonListWithDetails[0]
        if let hp = pokemon.detail.stats?[0].baseStat {
            hpFront.text = String(hp)
        }
        if let attack = pokemon.detail.stats?[1].baseStat {
            attackFront.text = String(attack)
        }
        if let defence = pokemon.detail.stats?[2].baseStat {
            defenceFront.text = String(defence)
        }
        self.pokemonNameFront.text = pokemon.name
        if let imageString = pokemon.detail.sprites?.frontDefault {
            if let imageUrl = URL(string: imageString) {
                if let data = try? Data(contentsOf: imageUrl) {
                    if let image = UIImage(data: data) {
                        self.imageViewFront.image = image
                    }
                }
            }
        }
        let pokemon2 = self.pokemonViewModel.pokemonListWithDetails[1]
        if let hp2 = pokemon2.detail.stats?[0].baseStat {
            hpBack.text = String(hp2)
        }
        if let attack2 = pokemon2.detail.stats?[1].baseStat {
            attackBack.text = String(attack2)
        }
        if let defence2 = pokemon2.detail.stats?[2].baseStat {
            defenceBack.text = String(defence2)
        }
        self.pokemonNameBack.text = pokemon2.name
        if let imageString2 = pokemon2.detail.sprites?.frontDefault {
            if let imageUrl2 = URL(string: imageString2) {
                if let data2 = try? Data(contentsOf: imageUrl2) {
                    if let image2 = UIImage(data: data2) {
                        self.imageViewBack.image = image2
                    }
                }
            }
        }
    }
    private func addViews() {
        containerViewFront.addSubview(imageViewFront)
        containerViewFront.addSubview(hpLabelFront)
        containerViewFront.addSubview(attackLabelFront)
        containerViewFront.addSubview(defenceLabelFront)
        containerViewFront.addSubview(hpFront)
        containerViewFront.addSubview(attackFront)
        containerViewFront.addSubview(defenceFront)
        containerViewFront.addSubview(pokemonNameFront)
        
        containerViewBack.addSubview(loadingLabel)
        
        containerViewBack.addSubview(imageViewBack)
        containerViewBack.addSubview(hpLabelBack)
        containerViewBack.addSubview(attackLabelBack)
        containerViewBack.addSubview(defenceLabelBack)
        containerViewBack.addSubview(hpBack)
        containerViewBack.addSubview(attackBack)
        containerViewBack.addSubview(defenceBack)
        containerViewBack.addSubview(pokemonNameBack)
        
        view.addSubview(containerViewFront)
        view.addSubview(containerViewBack)
        view.addSubview(reloadButton)
    }
    private func setupTapRecognizers() {
        let frontCardRecognizer = UITapGestureRecognizer(target: self, action: #selector(frontCardTapped))
        let backCardRecognizer = UITapGestureRecognizer(target: self, action: #selector(backCardTapped))
        let reloadButtonRecognizer = UITapGestureRecognizer(target: self, action: #selector(reloadTapped))
        containerViewFront.addGestureRecognizer(frontCardRecognizer)
        containerViewBack.addGestureRecognizer(backCardRecognizer)
        reloadButton.addGestureRecognizer(reloadButtonRecognizer)
        containerViewFront.isUserInteractionEnabled = false
        containerViewBack.isUserInteractionEnabled = false
        reloadButton.isUserInteractionEnabled = false
    }
    private func setupLayout() {
        sharedConstraints.append(contentsOf: [
            reloadButton.heightAnchor.constraint(equalToConstant: 72),
            reloadButton.widthAnchor.constraint(equalToConstant: 72),
            reloadButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            reloadButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            containerViewFront.heightAnchor.constraint(equalToConstant: 480),
            containerViewFront.widthAnchor.constraint(equalToConstant: 300),
            containerViewFront.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerViewFront.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            containerViewBack.heightAnchor.constraint(equalToConstant: 480),
            containerViewBack.widthAnchor.constraint(equalToConstant: 300),
            containerViewBack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerViewBack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            hpFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 18),
            hpFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -23),
            hpFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 419),
            hpFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -194),
            
            hpLabelFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 18),
            hpLabelFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -61),
            hpLabelFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 398),
            hpLabelFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -194),
            
            attackFront.centerXAnchor.constraint(equalTo: containerViewFront.centerXAnchor),
            attackFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -23),
            attackFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 419),
            
            attackLabelFront.centerXAnchor.constraint(equalTo: containerViewFront.centerXAnchor),
            attackLabelFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -61),
            attackLabelFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 398),
            
            defenceFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 194),
            defenceFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -23),
            defenceFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 419),
            defenceFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -18),
            
            defenceLabelFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 194),
            defenceLabelFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -61),
            defenceLabelFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 398),
            defenceLabelFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -18),
            
            hpBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 18),
            hpBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -23),
            hpBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 419),
            hpBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -194),
            
            hpLabelBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 18),
            hpLabelBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -61),
            hpLabelBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 398),
            hpLabelBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -194),
            
            attackBack.centerXAnchor.constraint(equalTo: containerViewBack.centerXAnchor),
            attackBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -23),
            attackBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 419),
            
            attackLabelBack.centerXAnchor.constraint(equalTo: containerViewBack.centerXAnchor),
            attackLabelBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -61),
            attackLabelBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 398),
            
            defenceBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 194),
            defenceBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -23),
            defenceBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 419),
            defenceBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -18),
            
            defenceLabelBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 194),
            defenceLabelBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -61),
            defenceLabelBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 398),
            defenceLabelBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -18),
            
            imageViewFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 183),
            imageViewFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -183),
            imageViewFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 99),
            imageViewFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -99),
            
            
            imageViewBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 183),
            imageViewBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -183),
            imageViewBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 99),
            imageViewBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -99)
            
        ])
        
        regularConstraints.append(contentsOf: [
            reloadButton.heightAnchor.constraint(equalToConstant: 72),
            reloadButton.widthAnchor.constraint(equalToConstant: 72),
            reloadButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            reloadButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            containerViewFront.heightAnchor.constraint(equalToConstant: 480),
            containerViewFront.widthAnchor.constraint(equalToConstant: 600),
            containerViewFront.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerViewFront.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            containerViewBack.heightAnchor.constraint(equalToConstant: 480),
            containerViewBack.widthAnchor.constraint(equalToConstant: 600),
            containerViewBack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerViewBack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            hpFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 36),
            hpFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -23),
            hpFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 419),
            hpFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -388),
            
            hpLabelFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 36),
            hpLabelFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -61),
            hpLabelFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 398),
            hpLabelFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -388),
            
            attackFront.centerXAnchor.constraint(equalTo: containerViewFront.centerXAnchor),
            attackFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -23),
            attackFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 419),
            
            attackLabelFront.centerXAnchor.constraint(equalTo: containerViewFront.centerXAnchor),
            attackLabelFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -61),
            attackLabelFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 398),
            
            defenceFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 388),
            defenceFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -23),
            defenceFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 419),
            defenceFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -36),
            
            defenceLabelFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 388),
            defenceLabelFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -61),
            defenceLabelFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 398),
            defenceLabelFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -36),
            
            hpBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 36),
            hpBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -23),
            hpBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 419),
            hpBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -388),
            
            hpLabelBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 36),
            hpLabelBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -61),
            hpLabelBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 398),
            hpLabelBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -388),
            
            attackBack.centerXAnchor.constraint(equalTo: containerViewBack.centerXAnchor),
            attackBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -23),
            attackBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 419),
            
            attackLabelBack.centerXAnchor.constraint(equalTo: containerViewBack.centerXAnchor),
            attackLabelBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -61),
            attackLabelBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 398),
            
            defenceBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 388),
            defenceBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -23),
            defenceBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 419),
            defenceBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -36),
            
            defenceLabelBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 388),
            defenceLabelBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -61),
            defenceLabelBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 398),
            defenceLabelBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -36),
            
            imageViewFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 140),
            imageViewFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -140),
            imageViewFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 198),
            imageViewFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -198),
            
            
            imageViewBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 140),
            imageViewBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -140),
            imageViewBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 198),
            imageViewBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -198)
            
        ])
        
        compactConstraints.append(contentsOf: [
            reloadButton.heightAnchor.constraint(equalToConstant: 48),
            reloadButton.widthAnchor.constraint(equalToConstant: 48),
            reloadButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            reloadButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            containerViewFront.heightAnchor.constraint(equalToConstant: 480),
            containerViewFront.widthAnchor.constraint(equalToConstant: 300),
            containerViewFront.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerViewFront.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            containerViewBack.heightAnchor.constraint(equalToConstant: 480),
            containerViewBack.widthAnchor.constraint(equalToConstant: 300),
            containerViewBack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerViewBack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        loadingLabel.text = "Loading..."
        
        reloadButton.image = UIImage(named: "reload")
        reloadButton.contentMode = .scaleAspectFit
        
        hpFront.font = UIFont.systemFont(ofSize: 32)
        attackFront.font = UIFont.systemFont(ofSize: 32)
        defenceFront.font = UIFont.systemFont(ofSize: 32)
        hpLabelFront.font = UIFont.systemFont(ofSize: 18)
        attackLabelFront.font = UIFont.systemFont(ofSize: 18)
        defenceLabelFront.font = UIFont.systemFont(ofSize: 18)
        hpBack.font = UIFont.systemFont(ofSize: 32)
        attackBack.font = UIFont.systemFont(ofSize: 32)
        defenceBack.font = UIFont.systemFont(ofSize: 32)
        hpLabelBack.font = UIFont.systemFont(ofSize: 18)
        attackLabelBack.font = UIFont.systemFont(ofSize: 18)
        defenceLabelBack.font = UIFont.systemFont(ofSize: 18)
        pokemonNameFront.font = UIFont.systemFont(ofSize: 24)
        pokemonNameBack.font = UIFont.systemFont(ofSize: 24)
        loadingLabel.font = UIFont.systemFont(ofSize: 24)
        
        attackFront.textAlignment = .center
        hpFront.textAlignment = .center
        defenceFront.textAlignment = .center
        attackLabelFront.textAlignment = .center
        hpLabelFront.textAlignment = .center
        defenceLabelFront.textAlignment = .center
        hpBack.textAlignment = .center
        attackBack.textAlignment = .center
        defenceBack.textAlignment = .center
        hpLabelBack.textAlignment = .center
        attackLabelBack.textAlignment = .center
        defenceLabelBack.textAlignment = .center
        pokemonNameFront.textAlignment = .center
        pokemonNameBack.textAlignment = .center
        loadingLabel.textAlignment = .center
        imageViewFront.contentMode = .scaleAspectFill
        imageViewBack.contentMode = .scaleAspectFill
        
        containerViewFront.translatesAutoresizingMaskIntoConstraints = false
        containerViewFront.backgroundColor = .white
        containerViewBack.translatesAutoresizingMaskIntoConstraints = false
        containerViewBack.backgroundColor = .white
        imageViewFront.translatesAutoresizingMaskIntoConstraints = false
        imageViewBack.translatesAutoresizingMaskIntoConstraints = false
        hpFront.translatesAutoresizingMaskIntoConstraints = false
        attackFront.translatesAutoresizingMaskIntoConstraints = false
        defenceFront.translatesAutoresizingMaskIntoConstraints = false
        hpLabelFront.translatesAutoresizingMaskIntoConstraints = false
        attackLabelFront.translatesAutoresizingMaskIntoConstraints = false
        defenceLabelFront.translatesAutoresizingMaskIntoConstraints = false
        hpBack.translatesAutoresizingMaskIntoConstraints = false
        attackBack.translatesAutoresizingMaskIntoConstraints = false
        defenceBack.translatesAutoresizingMaskIntoConstraints = false
        hpLabelBack.translatesAutoresizingMaskIntoConstraints = false
        attackLabelBack.translatesAutoresizingMaskIntoConstraints = false
        defenceLabelBack.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameFront.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameBack.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        loadingLabel.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 226).isActive = true
        loadingLabel.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -225).isActive = true
        loadingLabel.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 30).isActive = true
        loadingLabel.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -30).isActive = true
        
        pokemonNameFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 18).isActive = true
        pokemonNameFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -433).isActive = true
        pokemonNameFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 30).isActive = true
        pokemonNameFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -30).isActive = true
        
        pokemonNameBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 18).isActive = true
        pokemonNameBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -433).isActive = true
        pokemonNameBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 30).isActive = true
        pokemonNameBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -30).isActive = true
        
        containerViewFront.layer.cornerRadius = 36
        containerViewBack.layer.cornerRadius = 36
        
    }
    func layoutTrait(traitCollection:UITraitCollection) {
        if (!sharedConstraints[0].isActive) {
            
            //NSLayoutConstraint.activate(sharedConstraints)
        }
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
                constraintActivated = true
            }
            
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
                constraintActivated = true
            }
            
            NSLayoutConstraint.activate(regularConstraints)
            constraintActivated = true
        }
        if (!constraintActivated) {
            NSLayoutConstraint.activate(sharedConstraints)
        }
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        layoutTrait(traitCollection: traitCollection)
    }
}

