import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { MapPin, ChevronRight } from "lucide-react";
import { interests } from "../data/interests";
import { useApp } from "../context/AppContext";

export default function Onboarding() {
  const [step, setStep] = useState(0);
  const [selected, setSelected] = useState([]);
  const navigate = useNavigate();
  const { setSelectedInterests, generateRoute, setOnboardingDone } = useApp();

  const toggle = (id) => {
    setSelected((prev) =>
      prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id]
    );
  };

  const handleGo = () => {
    setSelectedInterests(selected);
    generateRoute(selected);
    setOnboardingDone(true);
    navigate("/stories");
  };

  return (
    <div className="min-h-dvh bg-gradient-to-br from-primary via-primary-dark to-purple-900 flex flex-col items-center justify-center px-6 text-white relative overflow-hidden">
      {/* Background decorations */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none">
        <div className="absolute -top-20 -right-20 w-64 h-64 bg-white/5 rounded-full blur-3xl" />
        <div className="absolute -bottom-32 -left-32 w-96 h-96 bg-secondary/10 rounded-full blur-3xl" />
      </div>

      <AnimatePresence mode="wait">
        {step === 0 && (
          <motion.div
            key="welcome"
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -30 }}
            transition={{ duration: 0.5 }}
            className="relative z-10 flex flex-col items-center text-center gap-6 max-w-sm"
          >
            <motion.div
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              transition={{ delay: 0.2, type: "spring", stiffness: 200 }}
              className="w-24 h-24 bg-white/15 backdrop-blur-sm rounded-3xl flex items-center justify-center"
            >
              <MapPin size={48} className="text-white" />
            </motion.div>

            <h1 className="text-4xl font-bold tracking-tight">Краевед</h1>
            <p className="text-white/80 text-lg leading-relaxed">
              Открой для себя удивительные места Краснодарского края.
              Мы составим для тебя идеальный маршрут путешествия.
            </p>

            <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={() => setStep(1)}
              className="mt-4 bg-white text-primary font-semibold px-8 py-4 rounded-2xl text-lg flex items-center gap-2 shadow-xl shadow-black/20"
            >
              Начать
              <ChevronRight size={20} />
            </motion.button>
          </motion.div>
        )}

        {step === 1 && (
          <motion.div
            key="interests"
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -30 }}
            transition={{ duration: 0.5 }}
            className="relative z-10 flex flex-col items-center w-full max-w-md"
          >
            <h2 className="text-2xl font-bold mb-2">Что тебе интересно?</h2>
            <p className="text-white/70 mb-6 text-center">
              Выбери минимум 2 интереса, и мы подберём маршрут
            </p>

            <div className="flex flex-wrap gap-2.5 justify-center mb-8 max-h-[50vh] overflow-y-auto px-2">
              {interests.map((interest, i) => {
                const isSelected = selected.includes(interest.id);
                return (
                  <motion.button
                    key={interest.id}
                    initial={{ opacity: 0, scale: 0.8 }}
                    animate={{ opacity: 1, scale: 1 }}
                    transition={{ delay: i * 0.03 }}
                    whileTap={{ scale: 0.9 }}
                    onClick={() => toggle(interest.id)}
                    className={`px-4 py-2.5 rounded-full text-sm font-medium transition-all duration-200 border-2 ${
                      isSelected
                        ? "bg-white text-primary border-white shadow-lg shadow-white/20"
                        : "bg-white/10 text-white border-white/20 hover:bg-white/20"
                    }`}
                  >
                    <span className="mr-1.5">{interest.emoji}</span>
                    {interest.name}
                  </motion.button>
                );
              })}
            </div>

            <motion.button
              whileHover={{ scale: selected.length >= 2 ? 1.05 : 1 }}
              whileTap={{ scale: selected.length >= 2 ? 0.95 : 1 }}
              onClick={handleGo}
              disabled={selected.length < 2}
              className={`w-full py-4 rounded-2xl text-lg font-semibold flex items-center justify-center gap-2 transition-all ${
                selected.length >= 2
                  ? "bg-white text-primary shadow-xl shadow-black/20"
                  : "bg-white/20 text-white/50 cursor-not-allowed"
              }`}
            >
              Поехали! 🚀
              {selected.length > 0 && (
                <span className="bg-primary/20 text-primary text-xs px-2 py-0.5 rounded-full">
                  {selected.length}
                </span>
              )}
            </motion.button>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}
